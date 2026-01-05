import SwiftUI

struct Typography {
    // MARK: - Display Fonts (Large Numbers)
    static func displayLarge(_ text: String) -> some View {
        Text(text)
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .minimumScaleFactor(0.8)
    }
    
    static func displayMedium(_ text: String) -> some View {
        Text(text)
            .font(.system(.title, design: .rounded, weight: .bold))
    }
    
    static func displaySmall(_ text: String) -> some View {
        Text(text)
            .font(.system(.title2, design: .rounded, weight: .semibold))
    }
    
    // MARK: - Headers
    static func headerLarge(_ text: String) -> some View {
        Text(text)
            .font(.system(.title, design: .default, weight: .medium))
    }
    
    static func headerMedium(_ text: String) -> some View {
        Text(text)
            .font(.system(.title2, design: .default, weight: .medium))
    }
    
    static func headerSmall(_ text: String) -> some View {
        Text(text)
            .font(.system(.title3, design: .default, weight: .medium))
    }
    
    // MARK: - Body Text
    static func bodyLarge(_ text: String) -> some View {
        Text(text)
            .font(.system(.body, design: .default, weight: .regular))
    }
    
    static func bodyMedium(_ text: String) -> some View {
        Text(text)
            .font(.system(.callout, design: .default, weight: .regular))
    }
    
    static func bodySmall(_ text: String) -> some View {
        Text(text)
            .font(.system(.footnote, design: .default, weight: .regular))
    }
    
    // MARK: - Quote Text
    static func quote(_ text: String) -> some View {
        Text(text)
            .font(.system(.title3, design: .serif, weight: .light))
            .italic()
            .multilineTextAlignment(.center)
    }
    
    static func quoteAuthor(_ text: String) -> some View {
        Text(text)
            .font(.system(.caption, design: .default, weight: .medium))
            .foregroundStyle(Theme.textSecondary)
    }
    
    // MARK: - Labels
    static func labelLarge(_ text: String) -> some View {
        Text(text)
            .font(.system(.headline, design: .default, weight: .semibold))
    }
    
    static func labelMedium(_ text: String) -> some View {
        Text(text)
            .font(.system(.subheadline, design: .default, weight: .medium))
    }
    
    static func labelSmall(_ text: String) -> some View {
        Text(text)
            .font(.system(.caption, design: .default, weight: .medium))
            .foregroundStyle(Theme.textTertiary)
    }
    
    // MARK: - Numeric Display
    static func numericLarge(_ value: String) -> some View {
        Text(value)
            .font(.system(size: 72, weight: .bold, design: .rounded))
            .minimumScaleFactor(0.7)
    }
    
    static func numericMedium(_ value: String) -> some View {
        Text(value)
            .font(.system(size: 48, weight: .semibold, design: .rounded))
    }
    
    static func numericSmall(_ value: String) -> some View {
        Text(value)
            .font(.system(size: 32, weight: .medium, design: .rounded))
    }
}

// MARK: - Text Modifiers
extension Text {
    func displayStyle(_ style: TextStyle) -> Text {
        switch style {
        case .displayLarge:
            return self.font(.system(.largeTitle, design: .rounded, weight: .bold))
        case .displayMedium:
            return self.font(.system(.title, design: .rounded, weight: .bold))
        case .displaySmall:
            return self.font(.system(.title2, design: .rounded, weight: .semibold))
        case .headerLarge:
            return self.font(.system(.title, design: .default, weight: .medium))
        case .headerMedium:
            return self.font(.system(.title2, design: .default, weight: .medium))
        case .headerSmall:
            return self.font(.system(.title3, design: .default, weight: .medium))
        case .bodyLarge:
            return self.font(.system(.body, design: .default, weight: .regular))
        case .bodyMedium:
            return self.font(.system(.callout, design: .default, weight: .regular))
        case .bodySmall:
            return self.font(.system(.footnote, design: .default, weight: .regular))
        case .labelLarge:
            return self.font(.system(.headline, design: .default, weight: .semibold))
        case .labelMedium:
            return self.font(.system(.subheadline, design: .default, weight: .medium))
        case .labelSmall:
            return self.font(.system(.caption, design: .default, weight: .medium))
        }
    }
}

enum TextStyle {
    case displayLarge, displayMedium, displaySmall
    case headerLarge, headerMedium, headerSmall
    case bodyLarge, bodyMedium, bodySmall
    case labelLarge, labelMedium, labelSmall
}