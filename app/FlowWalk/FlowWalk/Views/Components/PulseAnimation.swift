import SwiftUI

struct PulseAnimation: View {
    @State private var animationAmount: CGFloat = 1
    let color: Color
    let minScale: CGFloat
    let maxScale: CGFloat
    let duration: Double
    
    init(
        color: Color = .white,
        minScale: CGFloat = 0.8,
        maxScale: CGFloat = 1.2,
        duration: Double = 1.5
    ) {
        self.color = color
        self.minScale = minScale
        self.maxScale = maxScale
        self.duration = duration
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<3) { index in
                Circle()
                    .fill(color.opacity(0.3 - Double(index) * 0.1))
                    .scaleEffect(animationAmount + CGFloat(index) * 0.1)
                    .animation(
                        .easeInOut(duration: duration)
                        .repeatForever(autoreverses: true)
                        .delay(Double(index) * 0.2),
                        value: animationAmount
                    )
            }
        }
        .onAppear {
            animationAmount = maxScale
        }
    }
}

// MARK: - Breathing Button Modifier
struct BreathingButtonStyle: ViewModifier {
    @State private var isAnimating = false
    let gradient: LinearGradient
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    Circle()
                        .fill(gradient)
                        .scaleEffect(isAnimating ? 1.1 : 0.9)
                        .opacity(isAnimating ? 0.3 : 0.6)
                        .animation(
                            .easeInOut(duration: 3)
                            .repeatForever(autoreverses: true),
                            value: isAnimating
                        )
                    
                    Circle()
                        .fill(gradient)
                        .scaleEffect(isAnimating ? 1.05 : 0.95)
                        .opacity(isAnimating ? 0.5 : 0.4)
                        .animation(
                            .easeInOut(duration: 3)
                            .repeatForever(autoreverses: true)
                            .delay(0.5),
                            value: isAnimating
                        )
                }
            )
            .onAppear {
                isAnimating = true
            }
    }
}

extension View {
    func breathingAnimation(gradient: LinearGradient = Theme.primaryButtonGradient) -> some View {
        modifier(BreathingButtonStyle(gradient: gradient))
    }
}

#Preview {
    ZStack {
        Theme.backgroundGradient
            .ignoresSafeArea()
        
        VStack(spacing: 50) {
            // Simple pulse
            PulseAnimation()
                .frame(width: 100, height: 100)
            
            // Button with breathing animation
            Button(action: {}) {
                Image(systemName: "play.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                    .frame(width: 100, height: 100)
            }
            .breathingAnimation()
        }
    }
}