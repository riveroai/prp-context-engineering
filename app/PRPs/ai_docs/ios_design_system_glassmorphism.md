# iOS SwiftUI Glassmorphism Design System Guide

## Overview
Implementation patterns for creating a modern dark theme iOS app with glassmorphism, gradients, and spring animations.

## Color System

### Background Gradients
```swift
// Deep purple to black background
LinearGradient(
    colors: [Color(hex: "1a0033"), Color.black],
    startPoint: .top,
    endPoint: .bottom
)
```

### Heart Rate Zone Gradients
- **Optimal (110-130 BPM)**: Teal to green (#00D9FF → #00FF88)
- **Adjust Pace**: Orange to yellow (#FF6B6B → #FFE66D)
- **Too Fast/Slow**: Red to pink (#EC4899 → #FF6B6B)

## Glassmorphism Components

### Gradient Card Pattern
```swift
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
```

### Floating Badge Pattern
```swift
struct FloatingBadge: View {
    var body: some View {
        content
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
```

## Typography System

```swift
extension Font {
    static let largeNumber = Font.system(.largeTitle, design: .rounded, weight: .bold)
    static let header = Font.system(.title2, design: .default, weight: .medium)
    static let body = Font.system(.body, design: .default, weight: .regular)
    static let quote = Font.system(.body, design: .serif, weight: .light).italic()
}
```

## Animation Patterns

### Spring Animations
```swift
// Consistent spring animation
.animation(.spring(response: 0.3, dampingFraction: 0.8), value: animatedValue)

// Zone transition animation
.animation(.spring(response: 0.3, dampingFraction: 0.8), value: currentZone)
```

### Breathing Animation
```swift
@State private var isBreathing = false

Circle()
    .scaleEffect(isBreathing ? 1.1 : 1.0)
    .opacity(isBreathing ? 0.8 : 1.0)
    .animation(
        Animation.easeInOut(duration: 2.0)
            .repeatForever(autoreverses: true),
        value: isBreathing
    )
    .onAppear { isBreathing = true }
```

## Best Practices

1. **Performance**: Use `.drawingGroup()` for complex gradient animations
2. **Accessibility**: Ensure contrast ratios meet WCAG standards
3. **Dark Mode**: Design is inherently dark, no light mode needed
4. **Blur Effects**: Use sparingly to maintain 60fps
5. **Gradient Caching**: Create static gradient definitions to avoid recreation

## Common Patterns

### Full-Width Gradient Button
```swift
Button(action: action) {
    Text(title)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(gradient)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.3), radius: 8, y: 4)
}
```

### Zone-Based UI Updates
```swift
// Smooth color transitions based on heart rate
.background(
    GradientCard(gradient: Theme.zoneGradient(for: currentZone))
)
.animation(.spring(response: 0.3, dampingFraction: 0.8), value: currentZone)
```

## References
- [Human Interface Guidelines - Materials](https://developer.apple.com/design/human-interface-guidelines/materials)
- [SwiftUI Materials and Blur](https://developer.apple.com/documentation/swiftui/material)