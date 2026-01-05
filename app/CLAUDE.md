# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with the Flow Walk iOS application.

## Project Overview

**Flow Walk** is a SwiftUI-based iOS wellness application that combines mindful walking with real-time biometric feedback. The app guides users through 30-minute walking sessions with 432Hz ambient music, heart rate monitoring, and haptic feedback to maintain optimal walking pace.

## Core Architecture

### Technology Stack

- **UI Framework**: SwiftUI (iOS 18.0+)
- **Health Integration**: HealthKit for heart rate monitoring
- **Audio**: AVFoundation for 432Hz ambient music playback
- **Haptics**: CoreHaptics for biometric feedback
- **Motion**: CoreMotion for step counting
- **Location**: CoreLocation for distance tracking
- **Testing**: Swift Testing with XCTest UI Tests
- **Organization**: com.NeuraSync

### Project Structure

```
FlowWalk/
├── App/
│   ├── FlowWalkApp.swift          # App entry point
│   └── Info.plist                 # Permissions and config
├── Models/
│   ├── Session.swift              # Walking session data model
│   ├── HeartRateData.swift        # HR data structures
│   └── Quote.swift                # Daily affirmation model
├── ViewModels/
│   ├── HomeViewModel.swift        # Landing screen logic
│   ├── SessionViewModel.swift     # Active session state
│   └── SummaryViewModel.swift     # Post-session logic
├── Views/
│   ├── HomeView.swift             # Landing with daily quote
│   ├── SessionView.swift          # Active walking session
│   ├── SummaryView.swift          # Session summary
│   └── Components/
│       ├── ProgressRing.swift     # Apple Activity-style ring
│       ├── HeartRateDisplay.swift # Real-time BPM display
│       └── QuoteCard.swift        # Daily affirmation card
├── Services/
│   ├── HealthKitManager.swift     # HR monitoring service
│   ├── AudioManager.swift         # 432Hz music playback
│   ├── HapticManager.swift        # Haptic feedback service
│   └── LocationManager.swift      # Distance tracking
└── Resources/
    └── meditation_432hz.mp3       # Ambient audio file
```

## Development Principles

### Core Principles

- **KISS**: Keep the MVP simple - focus on core walking experience
- **Privacy First**: Minimal data collection, all processing on-device
- **Accessibility**: Full VoiceOver support and Dynamic Type
- **Battery Conscious**: Optimize for 30-minute continuous sessions

### Code Style

- Use Swift 6.0+ features (async/await, Observation framework)
- SwiftUI view files should be <200 lines
- ViewModels use `@Observable` macro
- Services use actor isolation for thread safety
- Bundle Identifier: com.NeuraSync.FlowWalk

### State Management

```swift
// Prefer @Observable for ViewModels
@Observable
class SessionViewModel {
    var heartRate: Double = 0
    var isInOptimalZone: Bool = true
    var sessionDuration: TimeInterval = 0
}

// Use @State/@Binding for view-local state
struct SessionView: View {
    @State private var isPaused = false
    @StateObject private var viewModel = SessionViewModel()
}
```

## Key Implementation Patterns

### HealthKit Integration

```swift
// Always check authorization before accessing
func requestHealthKitPermission() async throws {
    let types: Set = [HKQuantityType.heartRate]
    try await healthStore.requestAuthorization(toShare: [], read: types)
}

// Use HKAnchoredObjectQuery for real-time HR
func startHeartRateMonitoring() {
    let query = HKAnchoredObjectQuery(...)
    healthStore.execute(query)
}
```

### Haptic Feedback

```swift
// Different patterns for different zones
enum HapticPattern {
    case slowDown  // Above 130 BPM
    case speedUp   // Below 110 BPM
    case optimal   // In zone confirmation
}
```

### Background Audio

```swift
// Configure audio session for background playback
try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
try AVAudioSession.sharedInstance().setActive(true)
```

## Common Pitfalls & Solutions

### Apple Watch Connectivity

- Not all users have Apple Watch - provide graceful fallback
- Use `HKHealthStore.isHealthDataAvailable()` check
- Offer manual pace guidance when HR unavailable

### Background Modes

- Enable "Background Modes" in Info.plist for audio and location
- Handle app suspension during sessions gracefully
- Save session state periodically

### Permission Handling

```swift
// Required Info.plist keys:
NSHealthShareUsageDescription: "Flow Walk monitors your heart rate..."
NSLocationWhenInUseUsageDescription: "Flow Walk tracks distance..."
NSMotionUsageDescription: "Flow Walk counts your steps..."
```

## Testing Guidelines

### Unit Tests

```bash
# Run all tests
swift test

# Run with coverage
swift test --enable-code-coverage
```

### Key Test Scenarios

1. Missing Apple Watch / HealthKit unavailable
2. Background audio interruption (phone call)
3. Location permission denied
4. Session interruption and resume
5. Low battery mode behavior

### UI Testing Focus

- Accessibility inspector passes
- Dynamic Type support (xSmall to xxxLarge)
- Dark mode compatibility
- Haptic feedback on supported devices

## Development Commands

```bash
# Build and run
open FlowWalk.xcodeproj
# CMD+R to run

# SwiftLint (if integrated)
swiftlint

# Generate documentation
swift-doc generate Sources/ --output docs/
```

## Architecture Decisions

### Why SwiftUI over UIKit

- Modern declarative UI perfect for MVP
- Built-in animations for progress rings
- Simplified state management
- Better accessibility defaults

### Why 432Hz

- Claimed calming properties (though scientifically debated)
- User preference in wellness apps
- Differentiator from standard meditation apps

### Heart Rate Zones (110-130 BPM)

- Moderate intensity walking pace
- Sustainable for 30 minutes
- Promotes cardiovascular benefit without overexertion

## Next Features (Post-MVP)

- Apple Watch companion app
- Route recording and favorite routes
- Social sharing of achievements
- Integration with Apple Fitness
- Customizable session lengths
- Weather-aware recommendations

## External Resources

- [HealthKit Documentation](https://developer.apple.com/documentation/healthkit)
- [CoreHaptics Guide](https://developer.apple.com/documentation/corehaptics)
- [Background Audio Programming](https://developer.apple.com/documentation/avfaudio/avaudiosession)
- [SwiftUI State Management](https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app)

## Contact & Support

- Primary Developer: [Your Name]
- Design Resources: [Figma/Sketch Link]
- Project Board: [GitHub Projects/Jira]

---

Remember: This is an MVP focused on delivering a delightful 30-minute walking experience. Prioritize core functionality over feature complexity.
