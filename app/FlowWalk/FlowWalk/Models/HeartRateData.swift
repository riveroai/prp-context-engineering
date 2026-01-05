import Foundation

struct HeartRateReading: Codable {
    let timestamp: Date
    let bpm: Double
    let zone: HeartRateZone.Zone
}

struct HeartRateData {
    let value: Double
    let date: Date
    
    var zone: HeartRateZone.Zone {
        HeartRateZone.calculateZone(heartRate: value)
    }
}