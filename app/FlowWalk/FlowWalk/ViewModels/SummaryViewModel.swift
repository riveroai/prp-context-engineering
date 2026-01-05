import Foundation
import SwiftUI

@MainActor
@Observable
final class SummaryViewModel {
    // Observable properties
    var session: Session
    var reflection: String = ""
    var isSaving = false
    var showShareSheet = false
    
    // Dependencies
    private let dependencies: Dependencies
    
    init(session: Session, dependencies: Dependencies = .production) {
        self.session = session
        self.dependencies = dependencies
    }
    
    // MARK: - Computed Properties
    var formattedDuration: String {
        session.formattedDuration
    }
    
    var formattedDistance: String {
        session.formattedDistance
    }
    
    var formattedSteps: String {
        NumberFormatter.localizedString(from: NSNumber(value: session.totalSteps), number: .decimal)
    }
    
    var averageHeartRateText: String {
        if let avgHR = session.averageHeartRate {
            return "\(Int(avgHR)) BPM"
        } else {
            return "No data"
        }
    }
    
    var zoneBreakdown: [(zone: String, percentage: Double, color: LinearGradient)] {
        let percentages = session.zonePercentages
        
        return [
            (
                zone: "Optimal Zone",
                percentage: percentages.optimal,
                color: Theme.zoneGradient(for: .optimal)
            ),
            (
                zone: "Below Target",
                percentage: percentages.below,
                color: Theme.zoneGradient(for: .belowTarget)
            ),
            (
                zone: "Above Target",
                percentage: percentages.above,
                color: Theme.zoneGradient(for: .aboveTarget)
            )
        ].filter { $0.percentage > 0 }
    }
    
    var sessionSummaryText: String {
        """
        Flow Walk Session Summary
        
        Duration: \(formattedDuration)
        Distance: \(formattedDistance)
        Steps: \(formattedSteps)
        Average Heart Rate: \(averageHeartRateText)
        
        Zone Breakdown:
        • Optimal Zone: \(String(format: "%.0f%%", session.zonePercentages.optimal))
        • Below Target: \(String(format: "%.0f%%", session.zonePercentages.below))
        • Above Target: \(String(format: "%.0f%%", session.zonePercentages.above))
        
        \(reflection.isEmpty ? "" : "Reflection: \(reflection)")
        
        #FlowWalk #MindfulWalking #432Hz
        """
    }
    
    // MARK: - Actions
    func saveSession() async {
        guard !reflection.isEmpty else { return }
        
        isSaving = true
        defer { isSaving = false }
        
        session.reflection = reflection
        
        // In a real app, you would save to persistent storage here
        // For MVP, we're just updating the session object
        
        // Simulate save delay
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
    }
    
    func shareSession() {
        showShareSheet = true
    }
    
    func generateShareItems() -> [Any] {
        var items: [Any] = [sessionSummaryText]
        
        // In a real app, you might also generate an image of the session stats
        // For now, just share the text
        
        return items
    }
}