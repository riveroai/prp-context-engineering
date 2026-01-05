import Testing
import Foundation
@testable import FlowWalk

struct HeartRateZoneTests {
    
    @Test("Zone calculation handles all ranges correctly")
    func testZoneCalculation() {
        // Below target zone
        #expect(HeartRateZone.calculateZone(heartRate: 0) == .belowTarget)
        #expect(HeartRateZone.calculateZone(heartRate: 50) == .belowTarget)
        #expect(HeartRateZone.calculateZone(heartRate: 109) == .belowTarget)
        
        // Optimal zone (110-130 BPM)
        #expect(HeartRateZone.calculateZone(heartRate: 110) == .optimal)
        #expect(HeartRateZone.calculateZone(heartRate: 120) == .optimal)
        #expect(HeartRateZone.calculateZone(heartRate: 130) == .optimal)
        
        // Above target zone
        #expect(HeartRateZone.calculateZone(heartRate: 131) == .aboveTarget)
        #expect(HeartRateZone.calculateZone(heartRate: 150) == .aboveTarget)
        #expect(HeartRateZone.calculateZone(heartRate: 200) == .aboveTarget)
    }
    
    @Test("Zone optimal check returns correct values")
    func testIsInOptimalZone() {
        #expect(HeartRateZone.isInOptimalZone(heartRate: 109) == false)
        #expect(HeartRateZone.isInOptimalZone(heartRate: 110) == true)
        #expect(HeartRateZone.isInOptimalZone(heartRate: 120) == true)
        #expect(HeartRateZone.isInOptimalZone(heartRate: 130) == true)
        #expect(HeartRateZone.isInOptimalZone(heartRate: 131) == false)
    }
    
    @Test("Distance from optimal calculation")
    func testDistanceFromOptimal() {
        // Below optimal
        #expect(HeartRateZone.distanceFromOptimal(heartRate: 100) == 10)
        #expect(HeartRateZone.distanceFromOptimal(heartRate: 109) == 1)
        
        // In optimal zone
        #expect(HeartRateZone.distanceFromOptimal(heartRate: 110) == 0)
        #expect(HeartRateZone.distanceFromOptimal(heartRate: 120) == 0)
        #expect(HeartRateZone.distanceFromOptimal(heartRate: 130) == 0)
        
        // Above optimal
        #expect(HeartRateZone.distanceFromOptimal(heartRate: 131) == 1)
        #expect(HeartRateZone.distanceFromOptimal(heartRate: 140) == 10)
    }
    
    @Test("Zone descriptions are correct")
    func testZoneDescriptions() {
        #expect(HeartRateZone.Zone.belowTarget.description == "Speed Up")
        #expect(HeartRateZone.Zone.optimal.description == "Perfect Pace")
        #expect(HeartRateZone.Zone.aboveTarget.description == "Slow Down")
    }
    
    @Test("Zone color names are correct")
    func testZoneColorNames() {
        #expect(HeartRateZone.Zone.belowTarget.colorName == "yellow")
        #expect(HeartRateZone.Zone.optimal.colorName == "green")
        #expect(HeartRateZone.Zone.aboveTarget.colorName == "red")
    }
}