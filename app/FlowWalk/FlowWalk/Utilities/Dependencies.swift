import Foundation

struct Dependencies {
    let healthKitManager: HealthKitManager
    let audioManager: AudioManager
    let hapticManager: HapticManager
    let locationManager: LocationManager
    let stepCounter: StepCounter
    let quoteService: QuoteService
    
    static let production = Dependencies(
        healthKitManager: HealthKitManager(),
        audioManager: AudioManager(),
        hapticManager: HapticManager(),
        locationManager: LocationManager(),
        stepCounter: StepCounter(),
        quoteService: QuoteService()
    )
    
    // For testing
    static let test = Dependencies(
        healthKitManager: HealthKitManager(),
        audioManager: AudioManager(),
        hapticManager: HapticManager(),
        locationManager: LocationManager(),
        stepCounter: StepCounter(),
        quoteService: QuoteService()
    )
}