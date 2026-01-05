import Foundation
import CoreLocation

actor LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    private var locations: [CLLocation] = []
    private var totalDistance: Double = 0
    private var distanceContinuation: AsyncStream<Double>.Continuation?
    
    override init() {
        super.init()
        Task {
            await setupLocationManager()
        }
    }
    
    private func setupLocationManager() async {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 5 // Update every 5 meters
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    func requestAuthorization() async -> Bool {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            return await withCheckedContinuation { continuation in
                Task { @MainActor in
                    locationManager.requestWhenInUseAuthorization()
                    
                    // Set up a timer to check authorization status
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                        let newStatus = self.locationManager.authorizationStatus
                        if newStatus != .notDetermined {
                            timer.invalidate()
                            continuation.resume(returning: newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways)
                        }
                    }
                }
            }
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        default:
            return false
        }
    }
    
    func startTracking() -> AsyncStream<Double> {
        AsyncStream { continuation in
            self.distanceContinuation = continuation
            Task { @MainActor in
                self.locationManager.startUpdatingLocation()
            }
            
            continuation.onTermination = { _ in
                Task { await self.stopTracking() }
            }
        }
    }
    
    func stopTracking() async {
        await MainActor.run {
            locationManager.stopUpdatingLocation()
        }
        locations.removeAll()
        totalDistance = 0
        distanceContinuation?.finish()
        distanceContinuation = nil
    }
    
    func getCurrentDistance() -> Double {
        totalDistance
    }
    
    private func calculateDistance(from locations: [CLLocation]) -> Double {
        guard locations.count >= 2 else { return 0 }
        
        var distance: Double = 0
        for i in 1..<locations.count {
            distance += locations[i].distance(from: locations[i-1])
        }
        return distance
    }
}

extension LocationManager: CLLocationManagerDelegate {
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations newLocations: [CLLocation]) {
        Task {
            await handleLocationUpdate(newLocations)
        }
    }
    
    private func handleLocationUpdate(_ newLocations: [CLLocation]) async {
        // Filter out inaccurate locations
        let accurateLocations = newLocations.filter { location in
            location.horizontalAccuracy > 0 && location.horizontalAccuracy < 20
        }
        
        guard !accurateLocations.isEmpty else { return }
        
        // Add new locations
        locations.append(contentsOf: accurateLocations)
        
        // Keep only recent locations (last 5 minutes)
        let fiveMinutesAgo = Date().addingTimeInterval(-300)
        locations = locations.filter { $0.timestamp > fiveMinutesAgo }
        
        // Calculate total distance
        if locations.count >= 2 {
            totalDistance = calculateDistance(from: locations)
            distanceContinuation?.yield(totalDistance)
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)")
    }
    
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task {
            await handleAuthorizationChange()
        }
    }
    
    private func handleAuthorizationChange() async {
        let status = await MainActor.run { locationManager.authorizationStatus }
        print("Location authorization changed to: \(status)")
    }
}