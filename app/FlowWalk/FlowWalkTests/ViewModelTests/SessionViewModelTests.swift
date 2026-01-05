import Testing
import Foundation
@testable import FlowWalk

@MainActor
struct SessionViewModelTests {
    
    @Test("Heart rate zone calculation returns correct zones")
    func testHeartRateZoneCalculation() {
        let belowTarget = HeartRateZone.calculateZone(heartRate: 100)
        #expect(belowTarget == .belowTarget)
        
        let optimal = HeartRateZone.calculateZone(heartRate: 120)
        #expect(optimal == .optimal)
        
        let aboveTarget = HeartRateZone.calculateZone(heartRate: 140)
        #expect(aboveTarget == .aboveTarget)
        
        // Edge cases
        let lowerBound = HeartRateZone.calculateZone(heartRate: 110)
        #expect(lowerBound == .optimal)
        
        let upperBound = HeartRateZone.calculateZone(heartRate: 130)
        #expect(upperBound == .optimal)
    }
    
    @Test("Session metrics tracking updates correctly")
    func testSessionMetricsTracking() async {
        let viewModel = SessionViewModel(dependencies: .test)
        
        // Initial state
        #expect(viewModel.sessionState == .notStarted)
        #expect(viewModel.heartRate == 0)
        #expect(viewModel.steps == 0)
        #expect(viewModel.distance == 0)
        
        // Start session
        await viewModel.startSession()
        
        // Allow some time for initialization
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        #expect(viewModel.sessionState == .active)
        #expect(viewModel.duration >= 0)
    }
    
    @Test("Zone message updates based on heart rate")
    func testZoneMessageUpdates() {
        let viewModel = SessionViewModel(dependencies: .test)
        
        viewModel.currentZone = .optimal
        #expect(viewModel.zoneMessage == "Perfect pace! Keep it up")
        
        viewModel.currentZone = .belowTarget
        #expect(viewModel.zoneMessage == "Pick up the pace slightly")
        
        viewModel.currentZone = .aboveTarget
        #expect(viewModel.zoneMessage == "Slow down a bit")
    }
    
    @Test("Duration formatting works correctly")
    func testDurationFormatting() {
        let viewModel = SessionViewModel(dependencies: .test)
        
        viewModel.duration = 0
        #expect(viewModel.formattedDuration == "00:00")
        
        viewModel.duration = 65
        #expect(viewModel.formattedDuration == "01:05")
        
        viewModel.duration = 3661
        #expect(viewModel.formattedDuration == "61:01")
    }
    
    @Test("Distance formatting handles metric conversions")
    func testDistanceFormatting() {
        let viewModel = SessionViewModel(dependencies: .test)
        
        viewModel.distance = 0
        #expect(viewModel.formattedDistance == "0 m")
        
        viewModel.distance = 500
        #expect(viewModel.formattedDistance == "500 m")
        
        viewModel.distance = 1500
        #expect(viewModel.formattedDistance == "1.50 km")
        
        viewModel.distance = 2345
        #expect(viewModel.formattedDistance == "2.35 km")
    }
}