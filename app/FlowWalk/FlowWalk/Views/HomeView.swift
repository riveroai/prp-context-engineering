import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @State private var breathingScale: CGFloat = 1.0
    @State private var showingSession = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                Theme.backgroundGradient
                    .ignoresSafeArea()
                
                VStack(spacing: Theme.spacing.xl) {
                    // Title
                    Typography.headerLarge("Flow Walk")
                        .foregroundStyle(Theme.textPrimary)
                        .padding(.top, Theme.spacing.xl)
                    
                    Spacer()
                    
                    // Daily Quote Card
                    if let quote = viewModel.dailyQuote {
                        QuoteCard(quote: quote)
                            .padding(.horizontal, Theme.spacing.lg)
                            .transition(.opacity.combined(with: .scale))
                    }
                    
                    Spacer()
                    
                    // Start Button with breathing animation
                    Button(action: {
                        Task {
                            let canStart = await viewModel.startWalkTapped()
                            if canStart {
                                showingSession = true
                            }
                        }
                    }) {
                        ZStack {
                            // Breathing circle animation
                            Circle()
                                .fill(Theme.primaryButtonGradient)
                                .frame(width: 200, height: 200)
                                .scaleEffect(breathingScale)
                                .opacity(0.3)
                            
                            Circle()
                                .fill(Theme.primaryButtonGradient)
                                .frame(width: 180, height: 180)
                                .scaleEffect(breathingScale * 0.9)
                                .opacity(0.5)
                            
                            // Button content
                            VStack(spacing: Theme.spacing.sm) {
                                Image(systemName: "figure.walk")
                                    .font(.system(size: 50))
                                    .foregroundStyle(.white)
                                
                                Typography.labelLarge("Start Walk")
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .disabled(viewModel.isLoading)
                    .scaleEffect(viewModel.isLoading ? 0.95 : 1.0)
                    .animation(Theme.springAnimation, value: viewModel.isLoading)
                    
                    Spacer()
                }
                .padding(.bottom, Theme.spacing.xxl)
            }
            .onAppear {
                startBreathingAnimation()
            }
            .alert("Permissions Required", isPresented: $viewModel.showPermissionsAlert) {
                Button("Open Settings") {
                    viewModel.openSettings()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Please grant access to: \(viewModel.permissionsDenied.joined(separator: ", "))")
            }
            .fullScreenCover(isPresented: $showingSession) {
                SessionView()
            }
        }
    }
    
    private func startBreathingAnimation() {
        withAnimation(
            .easeInOut(duration: 3.0)
            .repeatForever(autoreverses: true)
        ) {
            breathingScale = 1.2
        }
    }
}

// MARK: - Quote Card Component
struct QuoteCard: View {
    let quote: Quote
    
    var body: some View {
        VStack(spacing: Theme.spacing.md) {
            Typography.quote(quote.text)
                .foregroundStyle(Theme.textPrimary)
                .multilineTextAlignment(.center)
            
            if let author = quote.author {
                Typography.quoteAuthor("— \(author)")
                    .foregroundStyle(Theme.textSecondary)
            }
        }
        .padding(Theme.spacing.lg)
        .frame(maxWidth: .infinity)
        .glassmorphic()
    }
}

#Preview {
    HomeView()
}