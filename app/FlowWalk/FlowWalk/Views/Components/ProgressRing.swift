import SwiftUI

struct ProgressRing: View {
    let progress: Double // 0.0 to 1.0
    let gradient: LinearGradient
    let lineWidth: CGFloat = 20
    
    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(
                    Color.white.opacity(0.1),
                    lineWidth: lineWidth
                )
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    gradient,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)
            
            // Shadow
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        colors: [Color.black.opacity(0.3), Color.clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(
                        lineWidth: lineWidth + 2,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .blur(radius: 4)
                .offset(y: 2)
        }
    }
}

#Preview {
    ZStack {
        Theme.backgroundGradient
            .ignoresSafeArea()
        
        ProgressRing(
            progress: 0.75,
            gradient: Theme.primaryButtonGradient
        )
        .frame(width: 200, height: 200)
    }
}