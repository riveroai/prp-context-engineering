import Foundation
import HealthKit

enum HealthKitError: LocalizedError {
    case healthDataNotAvailable
    case authorizationDenied
    case noHeartRateData
    case appleWatchNotPaired
    case workoutSessionFailed
    
    var errorDescription: String? {
        switch self {
        case .healthDataNotAvailable:
            return "Health data is not available on this device"
        case .authorizationDenied:
            return "Please grant health data access in Settings"
        case .noHeartRateData:
            return "No heart rate data available. Please ensure your Apple Watch is worn properly"
        case .appleWatchNotPaired:
            return "No Apple Watch paired. Heart rate monitoring requires an Apple Watch"
        case .workoutSessionFailed:
            return "Failed to start workout session"
        }
    }
}

actor HealthKitManager {
    private let healthStore = HKHealthStore()
    private var workoutSession: HKWorkoutSession?
    private var builder: HKLiveWorkoutBuilder?
    private var heartRateQuery: HKAnchoredObjectQuery?
    
    init() {}
    
    func requestAuthorization() async throws {
        guard HKHealthStore.isHealthDataAvailable() else {
            throw HealthKitError.healthDataNotAvailable
        }
        
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let workoutType = HKObjectType.workoutType()
        
        let typesToShare: Set<HKSampleType> = [workoutType]
        let typesToRead: Set<HKObjectType> = [
            heartRateType,
            stepCountType,
            distanceType,
            workoutType
        ]
        
        try await healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead)
    }
    
    func startHeartRateMonitoring() async throws -> AsyncStream<HeartRateData> {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .walking
        configuration.locationType = .outdoor
        
        do {
            workoutSession = try HKWorkoutSession(
                healthStore: healthStore,
                configuration: configuration
            )
            builder = workoutSession?.associatedWorkoutBuilder()
        } catch {
            throw HealthKitError.workoutSessionFailed
        }
        
        guard let workoutSession = workoutSession,
              let builder = builder else {
            throw HealthKitError.workoutSessionFailed
        }
        
        builder.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: configuration
        )
        
        let startDate = Date()
        workoutSession.startActivity(with: startDate)
        try await builder.beginCollection(at: startDate)
        
        return AsyncStream { continuation in
            let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
            let predicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: nil,
                options: .strictStartDate
            )
            
            let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = { _, samples, _, _, error in
                if let error = error {
                    print("Heart rate query error: \(error.localizedDescription)")
                    return
                }
                
                guard let samples = samples as? [HKQuantitySample] else { return }
                
                for sample in samples {
                    let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
                    let value = sample.quantity.doubleValue(for: heartRateUnit)
                    let data = HeartRateData(value: value, date: sample.startDate)
                    continuation.yield(data)
                }
            }
            
            let query = HKAnchoredObjectQuery(
                type: heartRateType,
                predicate: predicate,
                anchor: nil,
                limit: HKObjectQueryNoLimit,
                resultsHandler: updateHandler
            )
            
            query.updateHandler = updateHandler
            self.heartRateQuery = query
            self.healthStore.execute(query)
            
            continuation.onTermination = { _ in
                Task { await self.stopMonitoring() }
            }
        }
    }
    
    func stopMonitoring() async {
        if let query = heartRateQuery {
            healthStore.stop(query)
            heartRateQuery = nil
        }
        
        if let workoutSession = workoutSession {
            workoutSession.end()
            self.workoutSession = nil
        }
        
        if let builder = builder {
            do {
                try await builder.endCollection(at: Date())
                let workout = try await builder.finishWorkout()
                print("Workout saved: \(workout)")
            } catch {
                print("Failed to finish workout: \(error)")
            }
            self.builder = nil
        }
    }
    
    func checkAppleWatchAvailability() async -> Bool {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let authorizationStatus = healthStore.authorizationStatus(for: heartRateType)
        
        guard authorizationStatus == .sharingAuthorized else {
            return false
        }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: heartRateType,
            predicate: nil,
            limit: 1,
            sortDescriptors: [sortDescriptor]
        ) { _, samples, _ in
            // If we have recent heart rate data, Apple Watch is likely available
            return
        }
        
        return await withCheckedContinuation { continuation in
            var hasReturned = false
            let timeoutTask = Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 second timeout
                if !hasReturned {
                    hasReturned = true
                    continuation.resume(returning: false)
                }
            }
            
            let query = HKSampleQuery(
                sampleType: heartRateType,
                predicate: nil,
                limit: 1,
                sortDescriptors: [sortDescriptor]
            ) { _, samples, _ in
                if !hasReturned {
                    hasReturned = true
                    timeoutTask.cancel()
                    continuation.resume(returning: samples?.isEmpty == false)
                }
            }
            
            healthStore.execute(query)
        }
    }
}