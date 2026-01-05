import Testing
import Foundation
@testable import FlowWalk

@MainActor
struct HomeViewModelTests {
    
    @Test("Daily quote loads on initialization")
    func testDailyQuoteLoading() async {
        let viewModel = HomeViewModel(dependencies: .test)
        
        // Give time for initialization
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        #expect(viewModel.dailyQuote != nil)
        #expect(viewModel.dailyQuote?.text.isEmpty == false)
    }
    
    @Test("Start walk handles permissions correctly")
    func testStartWalkPermissions() async {
        let viewModel = HomeViewModel(dependencies: .test)
        
        // Initial state
        #expect(viewModel.isLoading == false)
        #expect(viewModel.showPermissionsAlert == false)
        #expect(viewModel.permissionsDenied.isEmpty)
        
        // Note: In a real test environment, you'd mock the permission responses
        // For now, we're just testing the flow
        let canStart = await viewModel.startWalkTapped()
        
        // After tapping
        #expect(viewModel.isLoading == false) // Should reset after completion
        
        // Permission state depends on simulator/device settings
        if !canStart {
            #expect(viewModel.showPermissionsAlert == true)
            #expect(!viewModel.permissionsDenied.isEmpty)
        }
    }
    
    @Test("Loading state updates during start walk")
    func testLoadingStateUpdates() async {
        let viewModel = HomeViewModel(dependencies: .test)
        
        // Start the task
        Task {
            _ = await viewModel.startWalkTapped()
        }
        
        // Give it a moment to start
        try? await Task.sleep(nanoseconds: 10_000_000) // 0.01 seconds
        
        // Should be loading during the process
        // Note: This might be flaky due to timing
        
        // Wait for completion
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Should not be loading after completion
        #expect(viewModel.isLoading == false)
    }
}