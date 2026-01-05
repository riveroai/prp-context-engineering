# Flow Walk iOS App

A minimalist wellness iOS application that transforms any walk into a moving meditation using 432Hz healing frequencies, real-time heart rate monitoring, and subtle haptic cues.

## Overview

Flow Walk guides users through mindful walking sessions with real-time biometric feedback, creating a seamless wellness experience that works with or without Apple Watch.

## Features

- 🚶 User-controlled walking sessions (no fixed duration)
- ❤️ Real-time heart rate monitoring via Apple Watch
- 🎵 Continuous 432Hz ambient music
- 📳 Haptic feedback for optimal pace guidance
- 📍 Distance and step tracking
- 🌟 Daily inspirational quotes
- 📊 Session summaries with zone breakdown
- 🌙 Beautiful dark theme with gradient accents

## Technical Stack

- **Platform**: iOS 18.0+
- **Language**: Swift 6.0
- **UI Framework**: SwiftUI
- **Architecture**: MVVM with Observation framework
- **Key Frameworks**: HealthKit, CoreLocation, CoreMotion, CoreHaptics, AVFoundation

## Project Structure

```
FlowWalk/
├── App/
│   ├── FlowWalkApp.swift          # App entry point
│   └── Info.plist                 # Permissions and config
├── Models/                        # Data models
├── ViewModels/                    # Business logic with @Observable
├── Views/                         # SwiftUI views
├── Services/                      # Platform services (actors)
├── Design/                        # Theme and typography
├── Resources/                     # Audio and assets
└── Utilities/                     # Helper extensions
```

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd FlowWalk
   ```

2. **Open in Xcode**
   ```bash
   open FlowWalk.xcodeproj
   ```

3. **Add 432Hz Audio File**
   - Add `meditation_432hz.mp3` to `FlowWalk/Resources/`
   - See `Resources/README_AUDIO.md` for requirements

4. **Configure Signing**
   - Select your development team in Xcode
   - Update bundle identifier if needed

5. **Build and Run**
   - Select your target device
   - Press Cmd+R to run

## Required Permissions

The app requests the following permissions:
- **HealthKit**: Heart rate monitoring
- **Location**: Distance tracking
- **Motion**: Step counting

All data is processed on-device and never shared.

## Testing

Run tests with:
```bash
swift test
```

Or in Xcode:
- Press Cmd+U to run all tests

## Heart Rate Zones

- **Optimal Zone**: 110-130 BPM (moderate walking pace)
- **Below Target**: < 110 BPM (speed up)
- **Above Target**: > 130 BPM (slow down)

## Design Philosophy

- **Minimalist**: Focus on essential features
- **Privacy First**: All data stays on device
- **Accessible**: Full VoiceOver and Dynamic Type support
- **Battery Conscious**: Optimized for 30+ minute sessions

## Future Enhancements

- Apple Watch companion app
- Route recording and favorites
- Social sharing features
- Integration with Apple Fitness
- Customizable session lengths
- Weather-aware recommendations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

[Add your license here]

## Acknowledgments

- 432Hz frequency chosen for its claimed calming properties
- Inspired by walking meditation practices
- Built with SwiftUI and modern iOS frameworks