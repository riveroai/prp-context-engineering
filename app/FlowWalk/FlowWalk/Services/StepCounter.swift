import Foundation
import CoreMotion

actor StepCounter {
    private let pedometer = CMPedometer()
    private var startDate: Date?
    private var stepsContinuation: AsyncStream<Int>.Continuation?
    
    init() {}
    
    func checkAvailability() -> Bool {
        return CMPedometer.isStepCountingAvailable()
    }
    
    func requestAuthorization() async -> Bool {
        // CoreMotion doesn't require explicit permission request
        // It uses the NSMotionUsageDescription in Info.plist
        // Authorization is granted when the user allows it in Settings
        return await withCheckedContinuation { continuation in
            // Try to query recent data to check if we have permission
            let now = Date()
            let oneHourAgo = now.addingTimeInterval(-3600)
            
            pedometer.queryPedometerData(from: oneHourAgo, to: now) { data, error in
                if let error = error as NSError? {
                    // Error code 105 means motion data is not available (permission denied)
                    continuation.resume(returning: error.code != 105)
                } else {
                    // If we can query data, we have permission
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func startCounting() -> AsyncStream<Int> {
        guard checkAvailability() else {
            return AsyncStream { continuation in
                continuation.finish()
            }
        }
        
        return AsyncStream { continuation in
            self.stepsContinuation = continuation
            self.startDate = Date()
            
            self.pedometer.startUpdates(from: Date()) { [weak self] data, error in
                Task {
                    await self?.handlePedometerUpdate(data: data, error: error)
                }
            }
            
            continuation.onTermination = { [weak self] _ in
                Task {
                    await self?.stopCounting()
                }
            }
        }
    }
    
    func stopCounting() async {
        pedometer.stopUpdates()
        stepsContinuation?.finish()
        stepsContinuation = nil
        startDate = nil
    }
    
    private func handlePedometerUpdate(data: CMPedometerData?, error: Error?) async {
        if let error = error {
            print("Pedometer error: \(error)")
            return
        }
        
        guard let data = data,
              let steps = data.numberOfSteps as? Int else {
            return
        }
        
        stepsContinuation?.yield(steps)
    }
    
    func querySteps(from startDate: Date, to endDate: Date) async throws -> Int {
        guard checkAvailability() else {
            throw StepCounterError.notAvailable
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            pedometer.queryPedometerData(from: startDate, to: endDate) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data,
                          let steps = data.numberOfSteps as? Int {
                    continuation.resume(returning: steps)
                } else {
                    continuation.resume(returning: 0)
                }
            }
        }
    }
}

enum StepCounterError: LocalizedError {
    case notAvailable
    case permissionDenied
    
    var errorDescription: String? {
        switch self {
        case .notAvailable:
            return "Step counting is not available on this device"
        case .permissionDenied:
            return "Please grant motion access in Settings to track your steps"
        }
    }
}