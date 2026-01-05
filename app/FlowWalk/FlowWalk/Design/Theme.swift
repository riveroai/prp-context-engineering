import SwiftUI

struct Theme {
    // MARK: - Background Gradients
    static let backgroundGradient = LinearGradient(
        colors: [Color(hex: "1a0033"), Color.black],
        startPoint: .top,
        endPoint: .bottom
    )
    
    // MARK: - Zone Gradients
    static func zoneGradient(for zone: HeartRateZone.Zone) -> LinearGradient {
        switch zone {
        case .optimal:
            return LinearGradient(
                colors: [Color(hex: "00D9FF"), Color(hex: "00FF88")],
                startPoint: .leading,
                endPoint: .trailing
            )
        case .belowTarget:
            return LinearGradient(
                colors: [Color(hex: "FFE66D"), Color(hex: "FFA500")],
                startPoint: .leading,
                endPoint: .trailing
            )
        case .aboveTarget:
            return LinearGradient(
                colors: [Color(hex: "FF6B6B"), Color(hex: "EC4899")],
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }
    
    // MARK: - Card Gradients
    static let cardGradient = LinearGradient(
        colors: [
            Color.white.opacity(0.1),
            Color.white.opacity(0.05)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // MARK: - Button Gradients
    static let primaryButtonGradient = LinearGradient(
        colors: [Color(hex: "00D9FF"), Color(hex: "00FF88")],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let destructiveButtonGradient = LinearGradient(
        colors: [Color(hex: "EC4899"), Color(hex: "FF6B6B")],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    // MARK: - Colors
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.8)
    static let textTertiary = Color.white.opacity(0.6)
    
    // MARK: - Spacing
    static let spacing = (
        xs: 4.0,
        sm: 8.0,
        md: 16.0,
        lg: 24.0,
        xl: 32.0,
        xxl: 48.0
    )
    
    // MARK: - Corner Radius
    static let cornerRadius = (
        sm: 8.0,
        md: 16.0,
        lg: 20.0,
        xl: 30.0
    )
    
    // MARK: - Animation
    static let springAnimation = Animation.spring(
        response: 0.3,
        dampingFraction: 0.8,
        blendDuration: 0
    )
    
    // MARK: - Shadow
    static func shadow(intensity: ShadowIntensity = .medium) -> (color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
        switch intensity {
        case .light:
            return (Color.black.opacity(0.2), 5, 0, 2)
        case .medium:
            return (Color.black.opacity(0.3), 10, 0, 5)
        case .heavy:
            return (Color.black.opacity(0.4), 15, 0, 8)
        }
    }
    
    enum ShadowIntensity {
        case light, medium, heavy
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - View Modifiers
extension View {
    func glassmorphic() -> some View {
        self
            .background(.ultraThinMaterial)
            .background(Theme.cardGradient)
            .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius.lg))
            .shadow(
                color: Theme.shadow().color,
                radius: Theme.shadow().radius,
                x: Theme.shadow().x,
                y: Theme.shadow().y
            )
    }
    
    func gradientButton(style: GradientButtonStyle = .primary) -> some View {
        self
            .foregroundStyle(.white)
            .font(.system(.title3, design: .rounded, weight: .semibold))
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(
                style == .primary ? Theme.primaryButtonGradient : Theme.destructiveButtonGradient
            )
            .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius.md))
            .shadow(
                color: Theme.shadow().color,
                radius: Theme.shadow().radius,
                x: Theme.shadow().x,
                y: Theme.shadow().y
            )
    }
}

enum GradientButtonStyle {
    case primary, destructive
}