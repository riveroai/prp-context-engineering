# Flow Walk Product Requirements Document

## 1. Executive Summary

Flow Walk transforms any walk into a moving meditation. This minimalist iOS companion uses 432Hz healing frequencies, real-time heart rate monitoring, and subtle haptic cues to guide you into the perfect 110-130 BPM rhythm. No timers, no pressure—just tap start when you begin and stop when you're complete. Walk for 5 minutes or 50, the choice is yours.

## 2. Core Features

### 2.1 Landing Screen

- Daily inspirational quote/affirmation
- Prominent "Start Walk" button with breathing animation

### 2.2 Walking Session (User-controlled duration)

- Real-time heart rate display from Apple Watch
- Progress timer showing elapsed time (no target)
- Color-coded heart rate zones:
  - Green: Optimal (110-130 BPM)
  - Yellow: Adjust pace needed
  - Red: Too fast/slow
- Continuous 432Hz ambient music (looping)
- Haptic feedback when leaving optimal zone
- Distance and step tracking
- Simple pause/resume functionality

### 2.3 Session Summary

- Total duration, distance, steps
- Average heart rate and time in zones
- Reflection prompt for mindfulness
- Save and share options

## 3. Technical Stack

- **Platform**: iOS 18.0+
- **UI Framework**: SwiftUI
- **Language**: Swift 6.0
- **Health Data**: HealthKit
- **Audio**: AVFoundation
- **Haptics**: CoreHaptics
- **Location**: CoreLocation
- **Motion**: CoreMotion
- **Testing**: Swift Testing with XCTest UI Tests
- **Bundle ID**: com.NeuraSync.FlowWalk

## 4. User Flow

### 4.1 First Launch

1. Welcome screen
2. Permission requests (HealthKit, Location, Motion)
3. Apple Watch pairing (optional)
4. Landing screen

### 4.2 Session Flow

1. User taps "Start Walk"
2. 432Hz music begins (continuous loop)
3. Real-time HR monitoring starts
4. Haptic guidance throughout
5. User taps "Stop" when ready
6. Summary and reflection appear

## 5. MVP Scope

### Included

- Flexible session length (user-controlled)
- Basic quote rotation
- Core biometric monitoring
- Local data storage
- Haptic feedback
- Continuous music looping

### Excluded (Future)

- Multiple session lengths
- Social features
- Historical analytics
- Apple Watch app
- Subscription features

## 6. Success Metrics

- Average session length >10 minutes
- App Store rating 4.5+
- Weekly active users retention >60%
- Average 3+ sessions per week per user
- Session completion rate >90% (user-initiated stops)

## 7. Constraints

- Must work without Apple Watch (graceful degradation)
- Battery usage <10% per session
- Full offline functionality for MVP
- Accessibility compliant (VoiceOver, Dynamic Type)

## 8. UI/UX Design Language

### Visual Style

- Dark theme with vibrant gradient accents
- Glassmorphism for depth and hierarchy
- Smooth spring animations (0.3s duration)
- Floating badge indicators for heart rate zones
- Minimalist approach - show only essential information during walks

### Color System

- **Background**: Deep purple to black gradient (#1a0033 to #000000)
- **Heart Rate Zones**:
  - Optimal (110-130 BPM): Teal to green gradient (#00D9FF to #00FF88)
  - Adjust Pace: Orange to yellow gradient (#FF6B6B to #FFE66D)
  - Too Fast/Slow: Red to pink gradient (#EC4899 to #FF6B6B)
- **UI Elements**: Gradient cards with subtle blur shadows
- **Text**: White primary, 80% opacity secondary

### Typography

- **Large Numbers**: SF Pro Display Bold (heart rate, timer)
- **Headers**: SF Pro Display Medium
- **Body Text**: SF Pro Text Regular
- **Quotes**: SF Pro Display Light Italic

### Component Patterns

- **Cards**: Gradient backgrounds with 20px corner radius
- **Buttons**: Full-width with gradient backgrounds, 60pt height
- **Progress Indicators**: Circular gradient rings
- **Status Badges**: Floating pills with blur background
- **Transitions**: Spring animations for all state changes

### Interaction Patterns

- Haptic feedback synchronized with visual transitions
- Tap to start/stop (no complex gestures during walk)
- Swipe down to dismiss summaries
- Long press for session options (pause/end)
- Breathing animation on buttons for calming effect
