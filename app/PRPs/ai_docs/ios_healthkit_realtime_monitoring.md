# iOS HealthKit Real-time Heart Rate Monitoring Guide

## Overview
This guide provides production-ready patterns for implementing real-time heart rate monitoring in iOS apps using HealthKit with proper error handling and Apple Watch integration.

## Key Implementation Requirements

### 1. Authorization Flow
```swift
// Always check device compatibility first
guard HKHealthStore.isHealthDataAvailable() else {
    throw HealthKitError.healthDataNotAvailable
}

// Request minimal permissions
let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
try await healthStore.requestAuthorization(toShare: [], read: [heartRateType])
```

### 2. Real-time Monitoring Pattern
- Use `HKWorkoutSession` for high-frequency heart rate sampling
- Implement `HKAnchoredObjectQuery` with update handler for continuous monitoring
- Process samples on background queue, update UI on MainActor

### 3. Critical Error Handling
```swift
enum HealthKitError: LocalizedError {
    case healthDataNotAvailable
    case authorizationDenied
    case noHeartRateData
    case appleWatchNotPaired
}
```

### 4. Heart Rate Zone Calculations
- Optimal zone: 110-130 BPM for moderate walking
- Implement zone tracking with haptic feedback transitions
- Track time in optimal zone for session summary

### 5. Background Session Management
- Start `HKWorkoutSession` for 30-minute continuous monitoring
- Handle app suspension gracefully
- Save session state periodically

## Common Pitfalls

1. **Privacy Ambiguity**: Cannot distinguish between denied permission and no data
2. **Data Latency**: Heart rate updates typically every 5 seconds with 300-500ms delay
3. **Simulator Limitations**: Always test on real devices with Apple Watch
4. **Authorization Status**: Handle ambiguity by assuming no data if not authorized

## Best Practices

1. Always provide fallback for non-Apple Watch users
2. Implement comprehensive error messages
3. Test extensively on real devices
4. Optimize for battery life during extended sessions
5. Use workout session for real-time updates

## References
- [HealthKit Documentation](https://developer.apple.com/documentation/healthkit)
- [Authorizing Access to Health Data](https://developer.apple.com/documentation/healthkit/authorizing-access-to-health-data)
- [HKWorkoutSession](https://developer.apple.com/documentation/healthkit/hkworkoutsession)