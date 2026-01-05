import Foundation
import SwiftUI

@MainActor
@Observable
final class SessionViewModel {
    // Observable properties
    var heartRate: Double = 0
    var currentZone: HeartRateZone.Zone = .optimal
    var duration: TimeInterval = 0
    var steps: Int = 0
    var distance: Double = 0
    var isPaused = false
    var sessionState: SessionState = .notStarted
    var showNoWatchAlert = false
    
    // Session data
    private var session: Session
    private var startTime: Date?
    private var lastZoneChangeTime: Date = Date()
    
    // Background tasks
    @ObservationIgnored
    private var heartRateTask: Task<Void, Never>?
    @ObservationIgnored
    private var locationTask: Task<Void, Never>?
    @ObservationIgnored
    private var stepTask: Task<Void, Never>?
    @ObservationIgnored
    private var timerTask: Task<Void, Never>?
    
    // Dependencies
    private let dependencies: Dependencies
    
    enum SessionState {
        case notStarted
        case active
        case paused
        case ending
        case completed
    }
    
    init(dependencies: Dependencies = .production) {
        self.dependencies = dependencies
        self.session = Session(startTime: Date())
    }
    
    func startSession() async {
        sessionState = .active
        startTime = Date()
        session = Session(startTime: startTime!)
        
        // Start audio immediately
        do {
            try await dependencies.audioManager.startMeditation432Hz()
        } catch {
            print("Failed to start audio: \(error)")
        }
        
        // Check Apple Watch availability
        let hasAppleWatch = await dependencies.healthKitManager.checkAppleWatchAvailability()
        if !hasAppleWatch {
            showNoWatchAlert = true
        }
        
        // Start all monitoring tasks in parallel
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.startHeartRateMonitoring() }
            group.addTask { await self.startLocationTracking() }
            group.addTask { await self.startStepCounting() }
            group.addTask { await self.startTimer() }
        }
    }
    
    private func startHeartRateMonitoring() async {
        heartRateTask = Task {
            do {
                for await heartRateData in try await dependencies.healthKitManager.startHeartRateMonitoring() {
                    guard !Task.isCancelled else { break }
                    
                    self.heartRate = heartRateData.value
                    let newZone = heartRateData.zone
                    
                    // Track zone changes
                    if newZone != self.currentZone {
                        self.updateZoneTime()
                        self.currentZone = newZone
                        self.lastZoneChangeTime = Date()
                    }
                    
                    // Add reading to session
                    let reading = HeartRateReading(
                        timestamp: heartRateData.date,
                        bpm: heartRateData.value,
                        zone: newZone
                    )
                    self.session.heartRateReadings.append(reading)
                    
                    // Update haptics
                    await self.dependencies.hapticManager.updateHeartRate(heartRateData.value)
                    
                    // Adjust audio volume based on zone
                    await self.dependencies.audioManager.adjustVolume(for: newZone)
                }
            } catch {
                print("Heart rate monitoring error: \(error)")
            }
        }
    }
    
    private func startLocationTracking() async {
        locationTask = Task {
            for await totalDistance in dependencies.locationManager.startTracking() {
                guard !Task.isCancelled else { break }
                self.distance = totalDistance
                self.session.totalDistance = totalDistance
            }
        }
    }
    
    private func startStepCounting() async {
        stepTask = Task {
            for await stepCount in dependencies.stepCounter.startCounting() {
                guard !Task.isCancelled else { break }
                self.steps = stepCount
                self.session.totalSteps = stepCount
            }
        }
    }
    
    private func startTimer() async {
        timerTask = Task {
            while !Task.isCancelled {
                if sessionState == .active {
                    self.duration = Date().timeIntervalSince(startTime ?? Date())
                }
                try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
            }
        }
    }
    
    func pauseSession() {
        guard sessionState == .active else { return }
        
        sessionState = .paused
        isPaused = true
        updateZoneTime()
        
        dependencies.audioManager.pauseMeditation()
    }
    
    func resumeSession() {
        guard sessionState == .paused else { return }
        
        sessionState = .active
        isPaused = false
        lastZoneChangeTime = Date()
        
        dependencies.audioManager.resumeMeditation()
    }
    
    func endSession() async -> Session {
        sessionState = .ending
        
        // Update final zone time
        updateZoneTime()
        
        // Stop all monitoring
        heartRateTask?.cancel()
        locationTask?.cancel()
        stepTask?.cancel()
        timerTask?.cancel()
        
        // Stop services
        await dependencies.healthKitManager.stopMonitoring()
        await dependencies.locationManager.stopTracking()
        await dependencies.stepCounter.stopCounting()
        await dependencies.audioManager.stopMeditation()
        await dependencies.hapticManager.playSessionEndHaptic()
        await dependencies.hapticManager.stopHaptics()
        
        // Finalize session
        session.endTime = Date()
        sessionState = .completed
        
        return session
    }
    
    private func updateZoneTime() {
        let timeInZone = Date().timeIntervalSince(lastZoneChangeTime)
        
        switch currentZone {
        case .optimal:
            session.timeInOptimalZone += timeInZone
        case .aboveTarget:
            session.timeAboveZone += timeInZone
        case .belowTarget:
            session.timeBelowZone += timeInZone
        }
    }
    
    // MARK: - Computed Properties
    var formattedDuration: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var formattedDistance: String {
        if distance < 1000 {
            return String(format: "%.0f m", distance)
        } else {
            return String(format: "%.2f km", distance / 1000)
        }
    }
    
    var zoneMessage: String {
        switch currentZone {
        case .optimal:
            return "Perfect pace! Keep it up"
        case .belowTarget:
            return "Pick up the pace slightly"
        case .aboveTarget:
            return "Slow down a bit"
        }
    }
}