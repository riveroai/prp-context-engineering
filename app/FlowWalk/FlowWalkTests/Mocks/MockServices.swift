import Foundation
@testable import FlowWalk

// MARK: - Mock HealthKit Manager
actor MockHealthKitManager: HealthKitManager {
    var shouldFailAuthorization = false
    var mockHeartRateData: [HeartRateData] = []
    var hasAppleWatch = true
    
    override func requestAuthorization() async throws {
        if shouldFailAuthorization {
            throw HealthKitError.authorizationDenied
        }
    }
    
    override func checkAppleWatchAvailability() async -> Bool {
        return hasAppleWatch
    }
    
    override func startHeartRateMonitoring() async throws -> AsyncStream<HeartRateData> {
        AsyncStream { continuation in
            for data in mockHeartRateData {
                continuation.yield(data)
            }
            continuation.finish()
        }
    }
}

// MARK: - Mock Audio Manager
actor MockAudioManager: AudioManager {
    var isPlaying = false
    var volume: Float = 1.0
    
    override func startMeditation432Hz() async throws {
        isPlaying = true
    }
    
    override func stopMeditation() async {
        isPlaying = false
    }
    
    override func pauseMeditation() {
        // Mock implementation
    }
    
    override func resumeMeditation() {
        // Mock implementation
    }
}

// MARK: - Mock Location Manager
actor MockLocationManager: LocationManager {
    var mockDistance: Double = 0
    var shouldGrantPermission = true
    
    override func requestAuthorization() async -> Bool {
        return shouldGrantPermission
    }
    
    override func startTracking() -> AsyncStream<Double> {
        AsyncStream { continuation in
            continuation.yield(mockDistance)
            continuation.finish()
        }
    }
}

// MARK: - Mock Step Counter
actor MockStepCounter: StepCounter {
    var mockSteps: Int = 0
    var shouldGrantPermission = true
    
    override func requestAuthorization() async -> Bool {
        return shouldGrantPermission
    }
    
    override func startCounting() -> AsyncStream<Int> {
        AsyncStream { continuation in
            continuation.yield(mockSteps)
            continuation.finish()
        }
    }
}