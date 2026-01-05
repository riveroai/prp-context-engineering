import SwiftUI

struct SessionView: View {
    @State private var viewModel = SessionViewModel()
    @State private var showingSummary = false
    @State private var completedSession: Session?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Background gradient
            Theme.backgroundGradient
                .ignoresSafeArea()
            
            VStack(spacing: Theme.spacing.xl) {
                // Header
                HStack {
                    Typography.headerMedium("Walking Session")
                        .foregroundStyle(Theme.textPrimary)
                    
                    Spacer()
                    
                    // Duration
                    Typography.displaySmall(viewModel.formattedDuration)
                        .foregroundStyle(Theme.textPrimary)
                }
                .padding(.horizontal, Theme.spacing.lg)
                .padding(.top, Theme.spacing.xl)
                
                Spacer()
                
                // Heart Rate Display
                if viewModel.heartRate > 0 {
                    HeartRateDisplay(
                        heartRate: viewModel.heartRate,
                        zone: viewModel.currentZone
                    )
                    .padding(.horizontal, Theme.spacing.lg)
                    .transition(.scale.combined(with: .opacity))
                } else {
                    VStack(spacing: Theme.spacing.md) {
                        Image(systemName: "applewatch")
                            .font(.system(size: 60))
                            .foregroundStyle(Theme.textTertiary)
                        
                        Typography.bodyLarge("No Apple Watch detected")
                            .foregroundStyle(Theme.textSecondary)
                        
                        Typography.bodyMedium("Continue walking at a comfortable pace")
                            .foregroundStyle(Theme.textTertiary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(Theme.spacing.xl)
                    .glassmorphic()
                    .padding(.horizontal, Theme.spacing.lg)
                }
                
                // Zone Message
                Typography.labelMedium(viewModel.zoneMessage)
                    .foregroundStyle(Theme.textSecondary)
                    .padding(.horizontal, Theme.spacing.lg)
                    .animation(.easeInOut, value: viewModel.currentZone)
                
                Spacer()
                
                // Metrics
                HStack(spacing: Theme.spacing.md) {
                    FloatingBadge(
                        title: "Steps",
                        value: "\(viewModel.steps)",
                        icon: "figure.walk"
                    )
                    
                    FloatingBadge(
                        title: "Distance",
                        value: viewModel.formattedDistance,
                        icon: "location"
                    )
                }
                .padding(.horizontal, Theme.spacing.lg)
                
                // Control Buttons
                HStack(spacing: Theme.spacing.md) {
                    Button(action: {
                        if viewModel.isPaused {
                            viewModel.resumeSession()
                        } else {
                            viewModel.pauseSession()
                        }
                    }) {
                        Text(viewModel.isPaused ? "Resume" : "Pause")
                    }
                    .gradientButton()
                    
                    Button(action: {
                        Task {
                            completedSession = await viewModel.endSession()
                            showingSummary = true
                        }
                    }) {
                        Text("Stop")
                    }
                    .gradientButton(style: .destructive)
                }
                .padding(.horizontal, Theme.spacing.lg)
                .padding(.bottom, Theme.spacing.xxl)
            }
        }
        .task {
            await viewModel.startSession()
        }
        .alert("No Apple Watch", isPresented: $viewModel.showNoWatchAlert) {
            Button("Continue Anyway") { }
        } message: {
            Text("Heart rate monitoring requires an Apple Watch. You can still track your walk using steps and distance.")
        }
        .fullScreenCover(isPresented: $showingSummary) {
            if let session = completedSession {
                SummaryView(session: session)
            }
        }
    }
}

// MARK: - Heart Rate Display Component
struct HeartRateDisplay: View {
    let heartRate: Double
    let zone: HeartRateZone.Zone
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: Theme.spacing.md) {
            // Heart icon with pulse animation
            Image(systemName: "heart.fill")
                .font(.system(size: 40))
                .foregroundStyle(.white)
                .scaleEffect(pulseScale)
                .animation(
                    .easeInOut(duration: 60.0 / heartRate)
                    .repeatForever(autoreverses: true),
                    value: pulseScale
                )
            
            // BPM Display
            Typography.numericLarge("\(Int(heartRate))")
                .foregroundStyle(.white)
            
            Typography.labelSmall("BPM")
                .foregroundStyle(Theme.textSecondary)
            
            // Zone indicator
            Text(zone.description)
                .font(.system(.headline, design: .rounded, weight: .medium))
                .foregroundStyle(.white)
                .padding(.horizontal, Theme.spacing.md)
                .padding(.vertical, Theme.spacing.sm)
                .background(
                    Capsule()
                        .fill(Theme.zoneGradient(for: zone))
                )
        }
        .padding(Theme.spacing.xl)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: Theme.cornerRadius.lg)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.cornerRadius.lg)
                        .fill(Theme.zoneGradient(for: zone).opacity(0.3))
                )
        )
        .shadow(
            color: Theme.shadow(intensity: .medium).color,
            radius: Theme.shadow(intensity: .medium).radius,
            x: Theme.shadow(intensity: .medium).x,
            y: Theme.shadow(intensity: .medium).y
        )
        .onAppear {
            pulseScale = 1.1
        }
    }
}

// MARK: - Floating Badge Component
struct FloatingBadge: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: Theme.spacing.xs) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(Theme.textTertiary)
            
            Typography.displaySmall(value)
                .foregroundStyle(Theme.textPrimary)
            
            Typography.labelSmall(title)
                .foregroundStyle(Theme.textTertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Theme.spacing.md)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius.md))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.cornerRadius.md)
                .strokeBorder(Theme.textPrimary.opacity(0.1), lineWidth: 1)
        )
    }
}

#Preview {
    SessionView()
}