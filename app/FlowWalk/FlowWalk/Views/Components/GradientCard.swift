import SwiftUI

struct GradientCard: View {
    let gradient: LinearGradient
    let cornerRadius: CGFloat
    let glowIntensity: Double
    
    init(
        gradient: LinearGradient = Theme.cardGradient,
        cornerRadius: CGFloat = Theme.cornerRadius.lg,
        glowIntensity: Double = 0.3
    ) {
        self.gradient = gradient
        self.cornerRadius = cornerRadius
        self.glowIntensity = glowIntensity
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(gradient.opacity(glowIntensity))
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.3),
                                Color.white.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: Theme.shadow(intensity: .medium).color,
                radius: Theme.shadow(intensity: .medium).radius,
                x: Theme.shadow(intensity: .medium).x,
                y: Theme.shadow(intensity: .medium).y
            )
    }
}

// MARK: - Gradient Card Container
struct GradientCardContainer<Content: View>: View {
    let gradient: LinearGradient
    let content: () -> Content
    
    init(
        gradient: LinearGradient = Theme.cardGradient,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.gradient = gradient
        self.content = content
    }
    
    var body: some View {
        content()
            .padding(Theme.spacing.lg)
            .background(
                GradientCard(gradient: gradient)
            )
    }
}

// MARK: - Convenience Modifiers
extension View {
    func gradientCard(
        gradient: LinearGradient = Theme.cardGradient,
        padding: CGFloat = Theme.spacing.lg
    ) -> some View {
        self
            .padding(padding)
            .background(
                GradientCard(gradient: gradient)
            )
    }
    
    func glowingCard(
        zone: HeartRateZone.Zone,
        intensity: Double = 0.5
    ) -> some View {
        self
            .background(
                GradientCard(
                    gradient: Theme.zoneGradient(for: zone),
                    glowIntensity: intensity
                )
            )
    }
}

#Preview {
    ZStack {
        Theme.backgroundGradient
            .ignoresSafeArea()
        
        VStack(spacing: Theme.spacing.lg) {
            // Basic gradient card
            Text("Basic Card")
                .foregroundStyle(Theme.textPrimary)
                .gradientCard()
            
            // Zone-specific glowing card
            VStack {
                Typography.displayMedium("120")
                    .foregroundStyle(.white)
                Typography.labelMedium("BPM")
                    .foregroundStyle(Theme.textSecondary)
            }
            .glowingCard(zone: .optimal, intensity: 0.6)
            
            // Custom gradient card container
            GradientCardContainer(gradient: Theme.destructiveButtonGradient) {
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Warning Card")
                }
                .foregroundStyle(.white)
            }
        }
        .padding(Theme.spacing.lg)
    }
}