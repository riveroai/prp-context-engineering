import Foundation
import SwiftUI

@MainActor
@Observable
final class HomeViewModel {
    // Observable properties
    var dailyQuote: Quote?
    var isLoading = false
    var showPermissionsAlert = false
    var permissionsDenied: [String] = []
    
    // Dependencies
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies = .production) {
        self.dependencies = dependencies
        Task {
            await loadDailyQuote()
        }
    }
    
    func loadDailyQuote() async {
        dailyQuote = await dependencies.quoteService.getDailyQuote()
    }
    
    func startWalkTapped() async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        // Check and request permissions
        let permissionsGranted = await requestPermissions()
        
        if !permissionsGranted {
            showPermissionsAlert = true
            return false
        }
        
        // Prepare services
        do {
            try await dependencies.hapticManager.prepareHaptics()
            await dependencies.hapticManager.playSessionStartHaptic()
        } catch {
            print("Failed to prepare haptics: \(error)")
        }
        
        return true
    }
    
    private func requestPermissions() async -> Bool {
        var allGranted = true
        permissionsDenied.removeAll()
        
        // HealthKit
        do {
            try await dependencies.healthKitManager.requestAuthorization()
        } catch {
            permissionsDenied.append("Health Data")
            allGranted = false
        }
        
        // Location
        let locationGranted = await dependencies.locationManager.requestAuthorization()
        if !locationGranted {
            permissionsDenied.append("Location Services")
            allGranted = false
        }
        
        // Motion (Step counting)
        let motionGranted = await dependencies.stepCounter.requestAuthorization()
        if !motionGranted {
            permissionsDenied.append("Motion & Fitness")
            allGranted = false
        }
        
        return allGranted
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}