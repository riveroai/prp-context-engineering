import SwiftUI

struct SummaryView: View {
    @State private var viewModel: SummaryViewModel
    @FocusState private var isReflectionFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    init(session: Session) {
        _viewModel = State(initialValue: SummaryViewModel(session: session))
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            Theme.backgroundGradient
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: Theme.spacing.xl) {
                    // Header
                    VStack(spacing: Theme.spacing.sm) {
                        Typography.headerLarge("Session Complete!")
                            .foregroundStyle(Theme.textPrimary)
                        
                        Typography.bodyMedium("Great job on your mindful walk")
                            .foregroundStyle(Theme.textSecondary)
                    }
                    .padding(.top, Theme.spacing.xxl)
                    
                    // Main metrics card
                    VStack(spacing: Theme.spacing.lg) {
                        // Duration
                        MetricRow(
                            icon: "clock",
                            label: "Duration",
                            value: viewModel.formattedDuration
                        )
                        
                        Divider()
                            .background(Theme.textTertiary.opacity(0.3))
                        
                        // Distance
                        MetricRow(
                            icon: "location",
                            label: "Distance",
                            value: viewModel.formattedDistance
                        )
                        
                        Divider()
                            .background(Theme.textTertiary.opacity(0.3))
                        
                        // Steps
                        MetricRow(
                            icon: "figure.walk",
                            label: "Steps",
                            value: viewModel.formattedSteps
                        )
                        
                        Divider()
                            .background(Theme.textTertiary.opacity(0.3))
                        
                        // Average Heart Rate
                        MetricRow(
                            icon: "heart",
                            label: "Average Heart Rate",
                            value: viewModel.averageHeartRateText
                        )
                    }
                    .padding(Theme.spacing.lg)
                    .glassmorphic()
                    .padding(.horizontal, Theme.spacing.lg)
                    
                    // Zone breakdown
                    if !viewModel.zoneBreakdown.isEmpty {
                        VStack(alignment: .leading, spacing: Theme.spacing.md) {
                            Typography.labelLarge("Zone Breakdown")
                                .foregroundStyle(Theme.textPrimary)
                            
                            ForEach(viewModel.zoneBreakdown, id: \.zone) { item in
                                ZoneBreakdownRow(
                                    zone: item.zone,
                                    percentage: item.percentage,
                                    gradient: item.color
                                )
                            }
                        }
                        .padding(Theme.spacing.lg)
                        .glassmorphic()
                        .padding(.horizontal, Theme.spacing.lg)
                    }
                    
                    // Reflection input
                    VStack(alignment: .leading, spacing: Theme.spacing.md) {
                        Typography.labelLarge("How was your walk?")
                            .foregroundStyle(Theme.textPrimary)
                        
                        TextField("Add your reflection...", text: $viewModel.reflection, axis: .vertical)
                            .textFieldStyle(.plain)
                            .foregroundStyle(Theme.textPrimary)
                            .padding(Theme.spacing.md)
                            .background(
                                RoundedRectangle(cornerRadius: Theme.cornerRadius.sm)
                                    .fill(.ultraThinMaterial)
                            )
                            .lineLimit(3...6)
                            .focused($isReflectionFocused)
                    }
                    .padding(Theme.spacing.lg)
                    .glassmorphic()
                    .padding(.horizontal, Theme.spacing.lg)
                    
                    // Action buttons
                    VStack(spacing: Theme.spacing.md) {
                        Button(action: {
                            Task {
                                await viewModel.saveSession()
                                viewModel.shareSession()
                            }
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                        }
                        .gradientButton()
                        .disabled(viewModel.isSaving)
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Done")
                                .foregroundStyle(Theme.textPrimary)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                    }
                    .padding(.horizontal, Theme.spacing.lg)
                    .padding(.bottom, Theme.spacing.xxl)
                }
            }
        }
        .sheet(isPresented: $viewModel.showShareSheet) {
            ShareSheet(items: viewModel.generateShareItems())
        }
        .onTapGesture {
            isReflectionFocused = false
        }
    }
}

// MARK: - Metric Row Component
struct MetricRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundStyle(Theme.textTertiary)
                .frame(width: 30)
            
            Typography.labelMedium(label)
                .foregroundStyle(Theme.textSecondary)
            
            Spacer()
            
            Typography.displaySmall(value)
                .foregroundStyle(Theme.textPrimary)
        }
    }
}

// MARK: - Zone Breakdown Row
struct ZoneBreakdownRow: View {
    let zone: String
    let percentage: Double
    let gradient: LinearGradient
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.spacing.sm) {
            HStack {
                Typography.labelMedium(zone)
                    .foregroundStyle(Theme.textPrimary)
                
                Spacer()
                
                Typography.labelMedium("\(Int(percentage))%")
                    .foregroundStyle(Theme.textSecondary)
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.white.opacity(0.1))
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(gradient)
                        .frame(width: geometry.size.width * (percentage / 100), height: 8)
                        .animation(.easeInOut, value: percentage)
                }
            }
            .frame(height: 8)
        }
    }
}

// MARK: - Share Sheet
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    SummaryView(session: Session(startTime: Date()))
}