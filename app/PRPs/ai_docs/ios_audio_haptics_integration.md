# iOS Audio & Haptics Integration Guide

## Overview
Production patterns for implementing continuous background audio with synchronized haptic feedback in iOS wellness applications.

## Audio Implementation (432Hz Ambient Music)

### 1. Background Audio Configuration
```swift
// Info.plist requirement
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
</array>

// Audio session setup
try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers])
try AVAudioSession.sharedInstance().setActive(true)
```

### 2. Seamless Looping Pattern
Use `AVPlayerLooper` for truly seamless loops:
```swift
let playerItem = AVPlayerItem(url: audioURL)
let queuePlayer = AVQueuePlayer(playerItem: playerItem)
let playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
```

### 3. Interruption Handling
- Handle phone calls and system alerts
- Implement `AVAudioSession.interruptionNotification`
- Resume playback when appropriate

## Haptic Feedback Integration

### 1. Zone-Based Patterns
```swift
enum HeartRateZone {
    case belowTarget    // Quick ascending taps
    case optimal        // Soft confirmation pulse
    case aboveTarget    // Strong descending pulses
}
```

### 2. Battery-Efficient Strategy
- Trigger haptics only on zone transitions
- Use 30-second intervals for reminders
- Keep patterns under 2 seconds
- Intensity range: 0.3-0.7 for regular feedback

### 3. Device Compatibility
```swift
guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
    // Fallback to visual/audio cues
    return
}
```

## Synchronized Implementation

### Real-time Biometric Response
```swift
func updateHeartRate(_ heartRate: Double) {
    let newZone = calculateZone(heartRate)
    
    if newZone != currentZone {
        // Zone transition - immediate haptic
        playHapticPattern(for: newZone)
        
        // Adjust audio if needed
        adjustAudioVolume(for: newZone)
    }
}
```

## Best Practices

1. **Audio Priority**: Configure audio session before haptics
2. **Fade Transitions**: Implement audio fade-out on session end
3. **Testing**: Always test on real devices (haptics don't work in simulator)
4. **Fallbacks**: Provide alternatives for devices without haptic support

## Common Issues

1. **Audio Gaps**: Use AVPlayerLooper instead of AVAudioPlayer.numberOfLoops
2. **Haptic Engine Crashes**: Always check capabilities before initialization
3. **Background Audio**: Must enable background mode in Info.plist

## References
- [AVFoundation Audio](https://developer.apple.com/documentation/avfoundation/audio-playback-recording-and-processing)
- [CoreHaptics Guide](https://developer.apple.com/documentation/corehaptics/)
- [Background Audio Programming](https://developer.apple.com/documentation/avfaudio/avaudiosession)