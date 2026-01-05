# SwiftUI Observation Framework Pattern Guide (iOS 18.0+)

## Overview
Modern state management in SwiftUI using the Observation framework (@Observable macro) introduced in iOS 17+ for building reactive, performant iOS applications.

## Key Patterns

### 1. ViewModel with @Observable
```swift
@MainActor
@Observable
final class SessionViewModel {
    // Properties are automatically observable
    var heartRate: Double = 0
    var duration: TimeInterval = 0
    
    // Use @ObservationIgnored for non-UI properties
    @ObservationIgnored
    private var backgroundTask: Task<Void, Never>?
}
```

### 2. View Integration
```swift
struct SessionView: View {
    @State private var viewModel = SessionViewModel()
    
    var body: some View {
        // Properties automatically trigger updates
        Text("Heart Rate: \(viewModel.heartRate)")
    }
}
```

### 3. Service Layer with Actors
```swift
actor HealthKitManager {
    func startHeartRateMonitoring() async -> AsyncStream<HeartRateData> {
        AsyncStream { continuation in
            // Implementation
        }
    }
}
```

### 4. Real-time Updates Pattern
```swift
@MainActor
@Observable
final class SessionViewModel {
    func startSession() async {
        for await heartRateData in await healthKit.startHeartRateMonitoring() {
            self.heartRate = heartRateData.value
        }
    }
}
```

## Best Practices

1. **Use @MainActor**: Mark ViewModels with @MainActor for UI-bound state
2. **Actor Isolation**: Use actors for thread-safe services
3. **AsyncStream**: Perfect for real-time data streams
4. **Task Management**: Properly handle task cancellation
5. **Minimal MainActor.run**: Only use when absolutely necessary

## Migration from ObservableObject

Old Pattern:
```swift
class ViewModel: ObservableObject {
    @Published var value = 0
}
```

New Pattern:
```swift
@Observable
class ViewModel {
    var value = 0  // Automatically observable
}
```

## References
- [Observation Framework](https://developer.apple.com/documentation/observation)
- [Observable Macro](https://developer.apple.com/documentation/observation/observable())
- [WWDC23: Discover Observation in SwiftUI](https://developer.apple.com/videos/play/wwdc2023/10149/)