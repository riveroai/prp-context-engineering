import SwiftUI

@main
struct FlowWalkApp: App {
    init() {
        configureAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.dark)
        }
    }
    
    private func configureAppearance() {
        // Configure navigation bar appearance
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(Color.black.opacity(0.9))
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = .white
        
        // Configure tab bar appearance (if used in future)
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.black.opacity(0.9))
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().tintColor = UIColor(Color(hex: "00D9FF"))
        
        // Configure text field appearance
        UITextField.appearance().tintColor = UIColor(Color(hex: "00D9FF"))
        UITextView.appearance().tintColor = UIColor(Color(hex: "00D9FF"))
        
        // Configure segmented control (if used)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color(hex: "00D9FF"))
        UISegmentedControl.appearance().setTitleTextAttributes([
            .foregroundColor: UIColor.white
        ], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([
            .foregroundColor: UIColor.white.withAlphaComponent(0.6)
        ], for: .normal)
        
        // Configure switch (if used)
        UISwitch.appearance().onTintColor = UIColor(Color(hex: "00D9FF"))
        
        // Configure page control (if used)
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color(hex: "00D9FF"))
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
    }
}