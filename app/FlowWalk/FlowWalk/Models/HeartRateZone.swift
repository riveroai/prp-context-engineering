import Foundation

struct HeartRateZone {
    static let optimalRange = 110.0...130.0
    
    enum Zone: String, CaseIterable, Codable {
        case belowTarget = "Speed Up"
        case optimal = "Perfect Pace"
        case aboveTarget = "Slow Down"
        
        var description: String {
            rawValue
        }
        
        var colorName: String {
            switch self {
            case .belowTarget:
                return "yellow"
            case .optimal:
                return "green"
            case .aboveTarget:
                return "red"
            }
        }
    }
    
    static func calculateZone(heartRate: Double) -> Zone {
        if heartRate < optimalRange.lowerBound {
            return .belowTarget
        } else if heartRate > optimalRange.upperBound {
            return .aboveTarget
        } else {
            return .optimal
        }
    }
    
    static func isInOptimalZone(heartRate: Double) -> Bool {
        optimalRange.contains(heartRate)
    }
    
    static func distanceFromOptimal(heartRate: Double) -> Double {
        if heartRate < optimalRange.lowerBound {
            return optimalRange.lowerBound - heartRate
        } else if heartRate > optimalRange.upperBound {
            return heartRate - optimalRange.upperBound
        } else {
            return 0
        }
    }
}