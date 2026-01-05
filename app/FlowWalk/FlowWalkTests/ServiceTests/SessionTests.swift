import Testing
import Foundation
@testable import FlowWalk

struct SessionTests {
    
    @Test("Session duration calculates correctly")
    func testSessionDuration() {
        let startTime = Date()
        var session = Session(startTime: startTime)
        
        // Without end time, duration should be from start to now
        #expect(session.duration >= 0)
        #expect(session.duration < 1) // Should be less than 1 second
        
        // With end time
        let endTime = startTime.addingTimeInterval(300) // 5 minutes
        session.endTime = endTime
        #expect(session.duration == 300)
    }
    
    @Test("Average heart rate calculation")
    func testAverageHeartRate() {
        var session = Session(startTime: Date())
        
        // No readings
        #expect(session.averageHeartRate == nil)
        
        // Add readings
        session.heartRateReadings = [
            HeartRateReading(timestamp: Date(), bpm: 100, zone: .belowTarget),
            HeartRateReading(timestamp: Date(), bpm: 120, zone: .optimal),
            HeartRateReading(timestamp: Date(), bpm: 140, zone: .aboveTarget)
        ]
        
        #expect(session.averageHeartRate == 120)
    }
    
    @Test("Zone percentages calculation")
    func testZonePercentages() {
        var session = Session(startTime: Date())
        
        // No time tracked
        let emptyPercentages = session.zonePercentages
        #expect(emptyPercentages.optimal == 0)
        #expect(emptyPercentages.below == 0)
        #expect(emptyPercentages.above == 0)
        
        // With zone times
        session.timeInOptimalZone = 600  // 10 minutes
        session.timeBelowZone = 300      // 5 minutes
        session.timeAboveZone = 300      // 5 minutes
        
        let percentages = session.zonePercentages
        #expect(percentages.optimal == 50)
        #expect(percentages.below == 25)
        #expect(percentages.above == 25)
    }
    
    @Test("Duration formatting")
    func testFormattedDuration() {
        var session = Session(startTime: Date())
        
        // Test various durations
        session.endTime = session.startTime.addingTimeInterval(0)
        #expect(session.formattedDuration == "00:00")
        
        session.endTime = session.startTime.addingTimeInterval(65)
        #expect(session.formattedDuration == "01:05")
        
        session.endTime = session.startTime.addingTimeInterval(3725)
        #expect(session.formattedDuration == "62:05")
    }
    
    @Test("Distance formatting")
    func testFormattedDistance() {
        var session = Session(startTime: Date())
        
        session.totalDistance = 0
        #expect(session.formattedDistance == "0 m")
        
        session.totalDistance = 999
        #expect(session.formattedDistance == "999 m")
        
        session.totalDistance = 1000
        #expect(session.formattedDistance == "1.00 km")
        
        session.totalDistance = 5678
        #expect(session.formattedDistance == "5.68 km")
    }
}