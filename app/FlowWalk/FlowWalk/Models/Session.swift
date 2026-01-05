import Foundation

struct Session: Codable, Identifiable {
    let id = UUID()
    let startTime: Date
    var endTime: Date?
    
    var duration: TimeInterval {
        (endTime ?? Date()).timeIntervalSince(startTime)
    }
    
    // Metrics
    var heartRateReadings: [HeartRateReading] = []
    var totalSteps: Int = 0
    var totalDistance: Double = 0 // meters
    
    // Zone tracking
    var timeInOptimalZone: TimeInterval = 0
    var timeAboveZone: TimeInterval = 0
    var timeBelowZone: TimeInterval = 0
    
    // User reflection
    var reflection: String?
    
    // Computed properties
    var averageHeartRate: Double? {
        guard !heartRateReadings.isEmpty else { return nil }
        let sum = heartRateReadings.reduce(0) { $0 + $1.bpm }
        return sum / Double(heartRateReadings.count)
    }
    
    var zonePercentages: (optimal: Double, above: Double, below: Double) {
        let totalTime = timeInOptimalZone + timeAboveZone + timeBelowZone
        guard totalTime > 0 else { return (0, 0, 0) }
        
        return (
            optimal: (timeInOptimalZone / totalTime) * 100,
            above: (timeAboveZone / totalTime) * 100,
            below: (timeBelowZone / totalTime) * 100
        )
    }
    
    var formattedDuration: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var formattedDistance: String {
        if totalDistance < 1000 {
            return String(format: "%.0f m", totalDistance)
        } else {
            return String(format: "%.2f km", totalDistance / 1000)
        }
    }
}