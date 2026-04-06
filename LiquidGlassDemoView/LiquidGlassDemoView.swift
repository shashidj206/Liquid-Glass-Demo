import SwiftUI
import UIKit

struct LiquidGlassDemoView: View {
    
    var body: some View {
        ZStack {
            // MARK: - Background (important for glass to work)
            backgroundView.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    
                    sectionTitle("1. Material — Foundation")
                    materialExample
                    
                    sectionTitle("2. Background Blur")
                    blurExample
                    
                    sectionTitle("3. Layering")
                    layeringExample
                    
                    sectionTitle("4. Gradients & Masking")
                    gradientExample
                    
                    sectionTitle("5. Shadows & Highlights")
                    shadowExample
                }
                .padding()
            }
        }
        
    }
}

// MARK: - Background

private extension LiquidGlassDemoView {
    
    var backgroundView: some View {
        LinearGradient(
            colors: [
                Color.purple,
                Color.blue,
                Color.orange
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay(
            Image(systemName: "circle.grid.3x3.fill")
                .resizable()
                .scaledToFit()
                .opacity(0.08)
                .scaleEffect(3)
        )
    }
}

// MARK: - Section Title

private extension LiquidGlassDemoView {
    
    func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.title3.bold())
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - 1. Material Example

private extension LiquidGlassDemoView {
    
    var materialExample: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial) // ✅ System material
            .frame(height: 120)
            .overlay(
                Text("ultraThinMaterial")
                    .font(.headline)
            )
    }
}

// MARK: - 2. Blur Example (UIKit bridge)

private extension LiquidGlassDemoView {
    
    var blurExample: some View {
        BlurView(style: .systemUltraThinMaterial)
            .frame(height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                Text("UIVisualEffectView Blur")
                    .font(.headline)
            )
    }
}

// MARK: - 3. Layering Example

private extension LiquidGlassDemoView {
    
    var layeringExample: some View {
        ZStack {
            // Background content
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .opacity(0.4)
                .padding()
            
            // Glass layer
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
            
            // Foreground content
            VStack {
                Text("Layered Glass")
                    .font(.headline)
                Text("Background + Glass + Content")
                    .font(.caption)
            }
        }
        .frame(height: 150)
    }
}

// MARK: - 4. Gradient & Masking

private extension LiquidGlassDemoView {
    
    var gradientExample: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial)
            .frame(height: 140)
            .overlay(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.3),
                        Color.white.opacity(0.05)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .mask(
                RoundedRectangle(cornerRadius: 20)
            )
            .overlay(
                Text("Gradient Highlight")
                    .font(.headline)
            )
    }
}

// MARK: - 5. Shadow & Highlight

private extension LiquidGlassDemoView {
    
    var shadowExample: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial)
            .frame(height: 140)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .shadow(
                color: .black.opacity(0.2),
                radius: 12,
                y: 6
            )
            .overlay(
                Text("Depth: Shadow + Stroke")
                    .font(.headline)
            )
    }
}

// MARK: - UIKit Blur Wrapper

struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

// MARK: - Preview

#Preview {
    LiquidGlassDemoView()
}
