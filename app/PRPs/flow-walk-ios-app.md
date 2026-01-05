name: "Flow Walk iOS App - SwiftUI Mindfulness Walking App with Real-time Biometric Feedback"
description: |

## Purpose

Complete implementation of Flow Walk iOS app - a minimalist wellness application that transforms any walk into a moving meditation using 432Hz healing frequencies, real-time heart rate monitoring, and subtle haptic cues to guide users into the perfect 110-130 BPM rhythm.

## Core Principles

1. **Graceful Degradation**: App must work without Apple Watch using time-based guidance
2. **Battery Conscious**: Optimize for 30+ minute continuous sessions
3. **Privacy First**: All data processing on-device, minimal collection
4. **Accessibility**: Full VoiceOver support and Dynamic Type

---

## Goal

Build a production-ready iOS 18.0+ SwiftUI app that guides users through mindful walking sessions with real-time biometric feedback, creating a seamless wellness experience that works with or without Apple Watch.

## Why

- **Business Value**: Differentiated wellness app in growing mindfulness market
- **User Impact**: Makes meditation accessible through simple walking
- **Problem Solved**: Combines physical activity with mental wellness in an approachable format
- **Target Users**: Health-conscious individuals seeking stress reduction without complex meditation practices

## What

### User-Visible Behavior
1. Daily inspirational quote on launch
2. One-tap session start with immediate 432Hz music
3. Real-time heart rate display with color-coded zones
4. Haptic feedback for pace guidance
5. Session summary with reflection prompt

### Technical Requirements
- iOS 18.0+ with Swift 6.0
- SwiftUI with Observation framework
- HealthKit integration for heart rate
- Background audio and location support
- Haptic feedback via CoreHaptics
- Step counting via CoreMotion

### Design Language
- **Visual Style**: Dark theme with vibrant gradient accents and glassmorphism
- **Color System**: Deep purple-black background with teal-green (optimal), orange-yellow (adjust), red-pink (fast/slow) zone gradients
- **Typography**: SF Pro Display for numbers/headers, SF Pro Text for body
- **Animations**: Spring animations (0.3s) for all transitions
- **Components**: Gradient cards (20px radius), floating badges, 60pt gradient buttons

### Success Criteria

- [ ] App launches with daily quote and breathing animation
- [ ] 432Hz music plays continuously during sessions
- [ ] Heart rate displays in real-time (when available)
- [ ] Haptic feedback guides users to optimal zone
- [ ] Sessions track duration, distance, steps, and heart rate
- [ ] Graceful fallback when Apple Watch unavailable
- [ ] All data stored locally on device
- [ ] Battery usage <10% per 30-minute session

## All Needed Context

### Documentation & References

```yaml
# MUST READ - Include these in your context window
- url: https://developer.apple.com/documentation/healthkit/authorizing-access-to-health-data
  why: Critical for proper HealthKit permission flow and privacy handling

- url: https://developer.apple.com/documentation/corehaptics/preparing-your-app-to-play-haptics
  why: Required for implementing zone-based haptic patterns

- url: https://developer.apple.com/documentation/avfoundation/audio-playback-recording-and-processing
  why: Background audio configuration for 432Hz music looping

- url: https://developer.apple.com/documentation/observation
  why: Modern state management with @Observable macro

- docfile: PRPs/ai_docs/ios_healthkit_realtime_monitoring.md
  why: Production patterns for real-time heart rate with error handling

- docfile: PRPs/ai_docs/ios_swiftui_observation_pattern.md
  why: State management patterns for iOS 18.0+ with actor isolation

- docfile: PRPs/ai_docs/ios_audio_haptics_integration.md
  why: Synchronized audio and haptic feedback implementation

- file: flow-walk-prd.md
  why: Product requirements and feature specifications

- file: CLAUDE.md
  why: Project-specific conventions and architecture decisions
```

### Current Codebase Tree

```bash
/workspace/
├── CLAUDE.md
├── flow-walk-prd.md
└── PRPs/
    └── ai_docs/
        ├── ios_healthkit_realtime_monitoring.md
        ├── ios_swiftui_observation_pattern.md
        └── ios_audio_haptics_integration.md
```

### Desired Codebase Tree

```bash
/workspace/
├── FlowWalk/
│   ├── FlowWalk.xcodeproj/           # Xcode project file
│   ├── FlowWalk/                     # Main app target
│   │   ├── App/
│   │   │   ├── FlowWalkApp.swift     # App entry point with @main
│   │   │   └── Info.plist            # Permissions and configuration
│   │   ├── Models/
│   │   │   ├── Session.swift         # Walking session data model
│   │   │   ├── HeartRateData.swift   # Heart rate data structures
│   │   │   ├── Quote.swift           # Daily affirmation model
│   │   │   └── HeartRateZone.swift   # Zone calculations and types
│   │   ├── ViewModels/
│   │   │   ├── HomeViewModel.swift   # Landing screen logic
│   │   │   ├── SessionViewModel.swift # Active session state management
│   │   │   └── SummaryViewModel.swift # Post-session summary logic
│   │   ├── Views/
│   │   │   ├── HomeView.swift        # Landing with daily quote
│   │   │   ├── SessionView.swift     # Active walking session UI
│   │   │   ├── SummaryView.swift     # Session summary and reflection
│   │   │   └── Components/
│   │   │       ├── ProgressRing.swift     # Apple Activity-style ring
│   │   │       ├── HeartRateDisplay.swift # Real-time BPM display
│   │   │       ├── QuoteCard.swift        # Daily affirmation card
│   │   │       ├── PulseAnimation.swift   # Breathing animation
│   │   │       ├── GradientCard.swift     # Glassmorphic gradient cards
│   │   │       └── FloatingBadge.swift    # Zone status indicators
│   │   ├── Services/
│   │   │   ├── HealthKitManager.swift     # Heart rate monitoring service
│   │   │   ├── AudioManager.swift         # 432Hz music playback service
│   │   │   ├── HapticManager.swift        # Haptic feedback service
│   │   │   ├── LocationManager.swift      # Distance tracking service
│   │   │   ├── StepCounter.swift          # CoreMotion step counting
│   │   │   └── QuoteService.swift         # Daily quote provider
│   │   ├── Resources/
│   │   │   ├── meditation_432hz.mp3       # 30-minute ambient audio file
│   │   │   └── Assets.xcassets            # App icons and images
│   │   ├── Design/
│   │   │   ├── Theme.swift                # Color system and gradients
│   │   │   └── Typography.swift           # Font definitions
│   │   └── Utilities/
│   │       ├── Dependencies.swift         # Dependency injection container
│   │       └── Extensions.swift           # SwiftUI and Foundation extensions
│   └── FlowWalkTests/
│       ├── ViewModelTests/
│       │   ├── SessionViewModelTests.swift
│       │   └── HomeViewModelTests.swift
│       ├── ServiceTests/
│       │   ├── HealthKitManagerTests.swift
│       │   └── AudioManagerTests.swift
│       └── Mocks/
│           └── MockServices.swift         # Test doubles for services
└── README.md                              # Project documentation
```

### Known Gotchas & Library Quirks

```swift
// CRITICAL: HealthKit requires HKWorkoutSession for real-time heart rate
// Without workout session, updates are infrequent (every 5+ minutes)

// CRITICAL: iOS 16.4+ requires showsBackgroundLocationIndicator = true
// Or use kCLDistanceFilterNone for background location updates

// CRITICAL: AVAudioPlayer.numberOfLoops = -1 may have small gaps
// Use AVPlayerLooper for truly seamless audio loops

// CRITICAL: Haptics don't work on iPad or in simulator
// Always check CHHapticEngine.capabilitiesForHardware().supportsHaptics

// CRITICAL: @Observable requires @MainActor for UI-bound ViewModels
// Services should use actor isolation for thread safety

// CRITICAL: Cannot distinguish between HealthKit permission denied vs no data
// Always provide graceful fallback assuming no data available

// CRITICAL: Gradient performance - use CAGradientLayer for complex gradients
// SwiftUI gradients can impact performance with multiple overlapping views

// CRITICAL: Spring animations - use .spring(response: 0.3, dampingFraction: 0.8)
// Consistent animation timing creates cohesive experience
```

## Implementation Blueprint

### Core Data Models

```swift
// Session.swift - Core session data model
struct Session: Codable, Identifiable {
    let id = UUID()
    let startTime: Date
    var endTime: Date?
    var duration: TimeInterval { 
        (endTime ?? Date()).timeIntervalSince(startTime) 
    }
    
    // Metrics
    var heartRateReadings: [HeartRateReading] = []
    var totalSteps: Int = 0
    var totalDistance: Double = 0 // meters
    
    // Zone tracking
    var timeInOptimalZone: TimeInterval = 0
    var timeAboveZone: TimeInterval = 0
    var timeBelowZone: TimeInterval = 0
    
    // User reflection
    var reflection: String?
}

// HeartRateData.swift - Heart rate structures
struct HeartRateReading: Codable {
    let timestamp: Date
    let bpm: Double
    let zone: HeartRateZone.Zone
}

// HeartRateZone.swift - Zone calculations
struct HeartRateZone {
    static let optimalRange = 110.0...130.0
    
    enum Zone: String, CaseIterable {
        case belowTarget = "Speed Up"
        case optimal = "Perfect Pace"
        case aboveTarget = "Slow Down"
    }
}

// Quote.swift - Daily affirmation model
struct Quote: Codable {
    let text: String
    let author: String?
    let category: String
}
```

### List of Tasks to Complete

```yaml
Task 1: Create Xcode Project and Basic Structure
CREATE FlowWalk.xcodeproj:
  - iOS App template with SwiftUI interface
  - Minimum deployment: iOS 18.0
  - Bundle ID: com.NeuraSync.FlowWalk
  - Include Tests target

Task 2: Configure Info.plist and Capabilities
MODIFY FlowWalk/Info.plist:
  - ADD Health permissions (Share and Update)
  - ADD Location permissions (Always and WhenInUse)
  - ADD Motion usage description
  - ADD Background modes (audio, location)
  - ADD 432Hz audio file to Resources

Task 3: Implement Core Data Models
CREATE Models/Session.swift:
  - DEFINE session data structure
  - INCLUDE metrics properties
  - ADD Codable for local storage

CREATE Models/HeartRateData.swift:
  - DEFINE heart rate reading structure
  - INCLUDE zone calculation logic

CREATE Models/Quote.swift:
  - DEFINE quote structure
  - INCLUDE default quotes array

Task 4: Implement Service Layer with Actor Isolation
CREATE Services/HealthKitManager.swift:
  - USE actor isolation for thread safety
  - IMPLEMENT authorization flow
  - CREATE real-time monitoring with HKAnchoredObjectQuery
  - HANDLE Apple Watch unavailable scenario

CREATE Services/AudioManager.swift:
  - CONFIGURE AVAudioSession for background
  - IMPLEMENT AVPlayerLooper for seamless playback
  - HANDLE audio interruptions

CREATE Services/HapticManager.swift:
  - CHECK device capabilities
  - IMPLEMENT zone-based patterns
  - OPTIMIZE for battery efficiency

CREATE Services/LocationManager.swift:
  - CONFIGURE for fitness activity type
  - IMPLEMENT battery-efficient tracking
  - CALCULATE distance from location updates

CREATE Services/StepCounter.swift:
  - USE CMPedometer for step counting
  - IMPLEMENT live updates
  - HANDLE permission requests

Task 5: Implement ViewModels with @Observable
CREATE ViewModels/HomeViewModel.swift:
  - USE @MainActor @Observable pattern
  - FETCH daily quote
  - HANDLE session start

CREATE ViewModels/SessionViewModel.swift:
  - COORDINATE all services
  - UPDATE UI state in real-time
  - TRACK zone transitions
  - SAVE session data

CREATE ViewModels/SummaryViewModel.swift:
  - CALCULATE session statistics
  - FORMAT display data
  - HANDLE reflection input

Task 6: Create Design System
CREATE Design/Theme.swift:
  - DEFINE gradient color system
  - BACKGROUND: Deep purple to black (#1a0033 to #000000)
  - ZONE gradients: Optimal (teal-green), Adjust (orange-yellow), Fast/Slow (red-pink)
  - IMPLEMENT gradient helper functions

CREATE Design/Typography.swift:
  - DEFINE font hierarchy
  - LARGE numbers: SF Pro Display Bold
  - HEADERS: SF Pro Display Medium
  - BODY: SF Pro Text Regular
  - QUOTES: SF Pro Display Light Italic

Task 7: Build SwiftUI Views with Design System
CREATE Views/HomeView.swift:
  - GRADIENT background (#1a0033 to #000000)
  - GLASSMORPHIC quote card
  - BREATHING animation on start button
  - SPRING animations (0.3s)

CREATE Views/SessionView.swift:
  - REAL-TIME heart rate with gradient zones
  - FLOATING badge for zone status
  - GRADIENT progress ring
  - BLUR effects for depth

CREATE Views/SummaryView.swift:
  - GRADIENT cards for metrics
  - SWIPE down dismiss gesture
  - REFLECTION input with glassmorphism
  - SHARE with gradient button

CREATE Views/Components/:
  - ProgressRing with gradient strokes
  - HeartRateDisplay with zone gradients
  - QuoteCard with blur and gradients
  - PulseAnimation for breathing
  - GradientCard with 20px radius
  - FloatingBadge with blur background

Task 8: Implement Dependency Injection
CREATE Utilities/Dependencies.swift:
  - DEFINE Dependencies container
  - CREATE production configuration
  - CREATE test configuration
  - INJECT into ViewModels

Task 9: Add 432Hz Audio Resource
ADD Resources/meditation_432hz.mp3:
  - 30-minute high-quality loop
  - Optimized file size
  - Seamless loop points

Task 10: Implement Unit Tests
CREATE Tests for ViewModels:
  - TEST state transitions
  - TEST zone calculations
  - MOCK service dependencies
  - VERIFY error handling

CREATE Tests for Services:
  - TEST authorization flows
  - TEST data processing
  - USE protocol-based mocks

Task 11: Configure App Entry Point
CREATE App/FlowWalkApp.swift:
  - SETUP initial dependencies
  - CONFIGURE dark theme appearance
  - APPLY gradient accent colors
  - HANDLE app lifecycle
```

### Per-Task Implementation Details

```swift
// Task 4: HealthKitManager Implementation Pattern
actor HealthKitManager {
    private let healthStore = HKHealthStore()
    
    func requestAuthorization() async throws {
        // PATTERN: Check availability first
        guard HKHealthStore.isHealthDataAvailable() else {
            throw HealthKitError.healthDataNotAvailable
        }
        
        // CRITICAL: Define minimal permissions
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        try await healthStore.requestAuthorization(
            toShare: [HKQuantityType.workoutType()],
            read: [heartRateType]
        )
    }
    
    func startHeartRateMonitoring() async -> AsyncStream<HeartRateData> {
        // PATTERN: Use AsyncStream for SwiftUI integration
        AsyncStream { continuation in
            // CRITICAL: Start workout session for real-time updates
            // Configure HKWorkoutSession
            // Setup HKAnchoredObjectQuery with updateHandler
            // Yield values through continuation
        }
    }
}

// Task 5: SessionViewModel Pattern
@MainActor
@Observable
final class SessionViewModel {
    // Observable properties
    var heartRate: Double = 0
    var currentZone: HeartRateZone.Zone = .optimal
    var duration: TimeInterval = 0
    
    // Services injected
    private let dependencies: Dependencies
    
    // Background tasks
    private var monitoringTask: Task<Void, Never>?
    
    func startSession() async {
        // PATTERN: Parallel service startup
        monitoringTask = Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.monitorHeartRate() }
                group.addTask { await self.trackLocation() }
                group.addTask { await self.countSteps() }
            }
        }
        
        // Start audio immediately
        dependencies.audioManager.startMeditation432Hz()
    }
}

// Task 6: Design System Implementation
struct Theme {
    // PATTERN: Gradient definitions
    static let backgroundGradient = LinearGradient(
        colors: [Color(hex: "1a0033"), Color.black],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static func zoneGradient(for zone: HeartRateZone.Zone) -> LinearGradient {
        switch zone {
        case .optimal:
            return LinearGradient(
                colors: [Color(hex: "00D9FF"), Color(hex: "00FF88")],
                startPoint: .leading,
                endPoint: .trailing
            )
        case .belowTarget, .aboveTarget:
            return LinearGradient(
                colors: [Color(hex: "FF6B6B"), Color(hex: "FFE66D")],
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }
}

// Task 7: SessionView with Design System
struct SessionView: View {
    @State private var viewModel: SessionViewModel
    
    var body: some View {
        ZStack {
            // PATTERN: Gradient background
            Theme.backgroundGradient
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // PATTERN: Glassmorphic cards with gradients
                if viewModel.heartRate > 0 {
                    HeartRateDisplay(
                        heartRate: viewModel.heartRate,
                        zone: viewModel.currentZone
                    )
                    .background(
                        GradientCard(gradient: Theme.zoneGradient(for: viewModel.currentZone))
                    )
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: viewModel.currentZone)
                } else {
                    Text("Wear your Apple Watch for heart rate")
                        .foregroundStyle(.white.opacity(0.8))
                }
                
                // PATTERN: Floating badges for metrics
                HStack {
                    FloatingBadge(title: "Duration", value: viewModel.formattedDuration)
                    FloatingBadge(title: "Steps", value: "\(viewModel.steps)")
                }
                
                // PATTERN: Gradient buttons with 60pt height
                HStack(spacing: 20) {
                    GradientButton(title: "Pause", action: viewModel.pauseSession)
                    GradientButton(title: "Stop", action: viewModel.endSession, style: .destructive)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .task {
            await viewModel.startSession()
        }
    }
}

// Component Examples with Design System
struct GradientCard: View {
    let gradient: LinearGradient
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .fill(gradient.opacity(0.3))
            )
            .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
    }
}

struct FloatingBadge: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
            Text(value)
                .font(.system(.title2, design: .rounded, weight: .bold))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .strokeBorder(.white.opacity(0.2), lineWidth: 1)
        )
    }
}

struct GradientButton: View {
    let title: String
    let action: () -> Void
    var style: ButtonStyle = .primary
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    LinearGradient(
                        colors: style == .primary ? 
                            [Color(hex: "00D9FF"), Color(hex: "00FF88")] :
                            [Color(hex: "EC4899"), Color(hex: "FF6B6B")],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.3), radius: 8, y: 4)
        }
        .scaleEffect(style == .primary ? 1.0 : 0.95)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: style)
    }
}
```

### Integration Points

```yaml
XCODE PROJECT:
  - target: iOS 18.0
  - capabilities: HealthKit, Background Modes
  - info.plist: All required usage descriptions

DEPENDENCIES:
  - none: Pure SwiftUI/UIKit (no third-party libraries for MVP)

ASSETS:
  - audio: meditation_432hz.mp3 in Resources
  - icons: App icon in Assets.xcassets with dark theme
  - colors: Gradient definitions in Theme.swift
  - fonts: SF Pro Display and SF Pro Text variants

TESTING:
  - framework: Swift Testing + XCTest UI
  - pattern: Protocol-based mocking
  - coverage: Minimum 80% for business logic
```

## Validation Loop

### Level 1: Build and Syntax

```bash
# Open project and build
open FlowWalk.xcodeproj
# CMD+B to build

# Expected: Build succeeds with no errors
# If errors: Check Swift version, deployment target, missing files
```

### Level 2: Unit Tests

```swift
// Tests/SessionViewModelTests.swift
import Testing
@testable import FlowWalk

@Test func heartRateZoneCalculation() {
    let zone = HeartRateZone()
    
    #expect(zone.calculateZone(heartRate: 100) == .belowTarget)
    #expect(zone.calculateZone(heartRate: 120) == .optimal)
    #expect(zone.calculateZone(heartRate: 140) == .aboveTarget)
}

@Test func sessionMetricsTracking() async {
    let viewModel = SessionViewModel(dependencies: .test)
    
    await viewModel.startSession()
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    
    #expect(viewModel.duration > 0)
    #expect(viewModel.sessionState == .active)
}
```

```bash
# Run tests
swift test
# Expected: All tests pass
```

### Level 3: UI Testing

```swift
// UITests/FlowWalkUITests.swift
import XCTest

final class FlowWalkUITests: XCTestCase {
    func testSessionFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Start session
        app.buttons["Start Walk"].tap()
        
        // Verify session UI appears
        XCTAssertTrue(app.staticTexts["Duration"].exists)
        
        // Stop session
        app.buttons["Stop"].tap()
        
        // Verify summary appears
        XCTAssertTrue(app.staticTexts["Session Summary"].exists)
    }
}
```

### Level 4: Device Testing

```bash
# Real device testing checklist:
# 1. Install on iPhone with Apple Watch
# 2. Grant all permissions when prompted
# 3. Start walking session
# 4. Verify:
#    - Heart rate updates every 5 seconds
#    - Haptic feedback on zone changes
#    - Audio continues in background
#    - Distance tracking is accurate
# 5. Test without Apple Watch
# 6. Verify graceful fallback UI
```

### Level 5: Performance Validation

```bash
# Xcode Instruments testing:
# 1. Profile > Energy Log
# 2. Run 30-minute session
# 3. Verify battery usage <10%

# 4. Profile > Allocations
# 5. Verify no memory leaks
# 6. Memory usage stable during session
```

## Final Validation Checklist

- [ ] App builds without warnings: Xcode build succeeds
- [ ] All unit tests pass: `swift test`
- [ ] UI tests pass: Xcode UI test suite
- [ ] Real device: Heart rate updates smoothly
- [ ] Real device: Haptics trigger on zone changes
- [ ] Real device: Audio plays continuously
- [ ] Background: Audio continues when app backgrounded
- [ ] Permissions: All requests show correct descriptions
- [ ] Accessibility: VoiceOver navigation works
- [ ] Performance: 30-min session uses <10% battery

---

## Anti-Patterns to Avoid

- ❌ Don't request unnecessary HealthKit permissions
- ❌ Don't ignore graceful degradation without Apple Watch
- ❌ Don't use AVAudioPlayer.numberOfLoops for seamless audio
- ❌ Don't trigger haptics continuously (battery drain)
- ❌ Don't store health data without user consent
- ❌ Don't assume HealthKit authorization means data exists
- ❌ Don't test only in simulator (haptics/health won't work)
- ❌ Don't forget background mode configuration

---

## PRP Confidence Score: 9/10

This PRP provides comprehensive context for one-pass implementation with:
- Complete architecture blueprint
- All critical documentation references
- Known gotchas and solutions
- Clear validation gates
- Fallback patterns for edge cases

The only reduction from 10/10 is that real device testing with Apple Watch cannot be fully automated and requires manual validation.