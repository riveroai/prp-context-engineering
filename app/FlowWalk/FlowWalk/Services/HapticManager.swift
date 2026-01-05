import Foundation
import CoreHaptics

actor HapticManager {
    private var engine: CHHapticEngine?
    private var isHapticsAvailable: Bool = false
    private var lastHapticTime: Date = Date()
    private var currentZone: HeartRateZone.Zone = .optimal
    
    // Battery-efficient intervals
    private let minimumHapticInterval: TimeInterval = 30.0 // 30 seconds between reminders
    private let zoneTransitionCooldown: TimeInterval = 5.0 // 5 seconds cooldown after zone change
    
    init() {
        checkHapticCapability()
    }
    
    private func checkHapticCapability() {
        isHapticsAvailable = CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }
    
    func prepareHaptics() async throws {
        guard isHapticsAvailable else {
            print("Haptics not available on this device")
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
            // Handle engine reset
            engine?.resetHandler = { [weak self] in
                print("Haptic engine reset")
                Task {
                    try? await self?.restartEngine()
                }
            }
            
            // Handle engine stopped
            engine?.stoppedHandler = { [weak self] reason in
                print("Haptic engine stopped: \(reason)")
                Task {
                    try? await self?.restartEngine()
                }
            }
        } catch {
            print("Failed to prepare haptics: \(error)")
            throw error
        }
    }
    
    private func restartEngine() async throws {
        try engine?.start()
    }
    
    func updateHeartRate(_ heartRate: Double) async {
        let newZone = HeartRateZone.calculateZone(heartRate: heartRate)
        
        // Check if zone changed
        if newZone != currentZone {
            currentZone = newZone
            await playZoneTransitionHaptic(for: newZone)
            lastHapticTime = Date()
        } else if Date().timeIntervalSince(lastHapticTime) > minimumHapticInterval {
            // Play reminder haptic if in non-optimal zone
            if newZone != .optimal {
                await playReminderHaptic(for: newZone)
                lastHapticTime = Date()
            }
        }
    }
    
    private func playZoneTransitionHaptic(for zone: HeartRateZone.Zone) async {
        guard isHapticsAvailable, let engine = engine else { return }
        
        do {
            let pattern = try createZoneTransitionPattern(for: zone)
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play zone transition haptic: \(error)")
        }
    }
    
    private func playReminderHaptic(for zone: HeartRateZone.Zone) async {
        guard isHapticsAvailable, let engine = engine else { return }
        
        do {
            let pattern = try createReminderPattern(for: zone)
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play reminder haptic: \(error)")
        }
    }
    
    private func createZoneTransitionPattern(for zone: HeartRateZone.Zone) throws -> CHHapticPattern {
        var events: [CHHapticEvent] = []
        
        switch zone {
        case .optimal:
            // Soft confirmation pulse - entering optimal zone
            events.append(CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
                ],
                relativeTime: 0
            ))
            events.append(CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
                ],
                relativeTime: 0.1
            ))
            
        case .belowTarget:
            // Quick ascending taps - speed up
            for i in 0..<3 {
                let intensity = 0.3 + (Float(i) * 0.2)
                events.append(CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
                    ],
                    relativeTime: Double(i) * 0.15
                ))
            }
            
        case .aboveTarget:
            // Strong descending pulses - slow down
            for i in 0..<3 {
                let intensity = 0.7 - (Float(i) * 0.2)
                events.append(CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
                    ],
                    relativeTime: Double(i) * 0.2
                ))
            }
        }
        
        return try CHHapticPattern(events: events, parameters: [])
    }
    
    private func createReminderPattern(for zone: HeartRateZone.Zone) throws -> CHHapticPattern {
        var events: [CHHapticEvent] = []
        
        switch zone {
        case .optimal:
            // No reminder needed for optimal zone
            break
            
        case .belowTarget:
            // Gentle tap reminder to speed up
            events.append(CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
                ],
                relativeTime: 0
            ))
            
        case .aboveTarget:
            // Stronger tap reminder to slow down
            events.append(CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.4)
                ],
                relativeTime: 0
            ))
        }
        
        return try CHHapticPattern(events: events, parameters: [])
    }
    
    func playSessionStartHaptic() async {
        guard isHapticsAvailable, let engine = engine else { return }
        
        do {
            // Welcome pattern - gentle build up
            var events: [CHHapticEvent] = []
            
            for i in 0..<4 {
                let intensity = 0.2 + (Float(i) * 0.15)
                events.append(CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
                    ],
                    relativeTime: Double(i) * 0.2
                ))
            }
            
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play session start haptic: \(error)")
        }
    }
    
    func playSessionEndHaptic() async {
        guard isHapticsAvailable, let engine = engine else { return }
        
        do {
            // Completion pattern - gentle fade out
            var events: [CHHapticEvent] = []
            
            for i in 0..<3 {
                let intensity = 0.5 - (Float(i) * 0.15)
                events.append(CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
                    ],
                    relativeTime: Double(i) * 0.3
                ))
            }
            
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play session end haptic: \(error)")
        }
    }
    
    func stopHaptics() async {
        engine?.stop()
        engine = nil
    }
}