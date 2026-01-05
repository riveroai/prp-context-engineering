import Foundation

actor QuoteService {
    private var todaysQuote: Quote?
    private var lastQuoteDate: Date?
    
    init() {}
    
    func getDailyQuote() -> Quote {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Check if we need a new quote
        if let lastDate = lastQuoteDate,
           calendar.isDate(lastDate, inSameDayAs: today),
           let quote = todaysQuote {
            return quote
        }
        
        // Get new daily quote
        todaysQuote = Quote.dailyQuote()
        lastQuoteDate = today
        
        return todaysQuote!
    }
    
    func getRandomQuote() -> Quote {
        Quote.randomQuote()
    }
    
    func getQuoteForCategory(_ category: String) -> Quote? {
        Quote.defaultQuotes.filter { $0.category == category }.randomElement()
    }
}