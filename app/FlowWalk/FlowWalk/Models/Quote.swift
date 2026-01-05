import Foundation

struct Quote: Codable, Identifiable {
    let id = UUID()
    let text: String
    let author: String?
    let category: String
    
    static let defaultQuotes: [Quote] = [
        Quote(text: "The journey of a thousand miles begins with a single step.", author: "Lao Tzu", category: "journey"),
        Quote(text: "Walking is the best possible exercise. Habituate yourself to walk very far.", author: "Thomas Jefferson", category: "health"),
        Quote(text: "In every walk with nature, one receives far more than he seeks.", author: "John Muir", category: "nature"),
        Quote(text: "The rhythm of the body creates the light in the mind.", author: "B.K.S. Iyengar", category: "mindfulness"),
        Quote(text: "Walking meditation is meditation in action.", author: "Thich Nhat Hanh", category: "meditation"),
        Quote(text: "Movement is a medicine for creating change in a person's physical, emotional, and mental states.", author: "Carol Welch", category: "wellness"),
        Quote(text: "The path to inner peace begins with a single mindful step.", author: nil, category: "mindfulness"),
        Quote(text: "Every step is a prayer, every breath a meditation.", author: nil, category: "meditation"),
        Quote(text: "Walk as if you are kissing the Earth with your feet.", author: "Thich Nhat Hanh", category: "mindfulness"),
        Quote(text: "The body benefits from movement, and the mind benefits from stillness.", author: "Sakyong Mipham", category: "balance")
    ]
    
    static func randomQuote() -> Quote {
        defaultQuotes.randomElement() ?? defaultQuotes[0]
    }
    
    static func dailyQuote() -> Quote {
        let calendar = Calendar.current
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let index = (dayOfYear - 1) % defaultQuotes.count
        return defaultQuotes[index]
    }
}