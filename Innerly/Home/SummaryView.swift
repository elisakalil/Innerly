import SwiftUI

struct SummaryView: View {
    let entry: JournalEntry
    let onDismiss: () -> Void
    @State private var showingConfetti = false
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(
                    colors: [
                        Color.mint.opacity(0.2),
                        Color.teal.opacity(0.1),
                        Color.blue.opacity(0.05)
                    ],
                    center: .center,
                    startRadius: 100,
                    endRadius: 400
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Success Icon
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.mint.opacity(0.3), .teal.opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.teal, .mint],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        .scaleEffect(showingConfetti ? 1.1 : 1.0)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: showingConfetti)
                        
                        // Title
                        Text("Entry Saved!")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        
                        Text("Thank you for taking time to reflect")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                        
                        // Entry Summary Card
                        VStack(spacing: 20) {
                            // Detected Emotion
                            VStack(spacing: 12) {
                                HStack {
                                    Image(systemName: "face.smiling.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.teal)
                                    
                                    Text("Detected Emotion")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(entry.detectedEmotion)
                                        .font(.system(size: 24, weight: .bold, design: .rounded))
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [.teal, .mint],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                    
                                    Spacer()
                                }
                            }
                            
                            Divider()
                                .background(Color.teal.opacity(0.3))
                            
                            // Entry Preview
                            VStack(spacing: 12) {
                                HStack {
                                    Image(systemName: "quote.opening")
                                        .font(.system(size: 16))
                                        .foregroundColor(.teal)
                                    
                                    Text("Your Reflection")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                
                                Text(entry.text)
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            // Date
                            HStack {
                                Image(systemName: "calendar")
                                    .font(.system(size: 14))
                                    .foregroundColor(.teal)
                                
                                Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                            }
                        }
                        .padding(24)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        colors: [.teal.opacity(0.3), .mint.opacity(0.3)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                        
                        // Action Buttons
                        VStack(spacing: 16) {
                            Button(action: onDismiss) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Text("Write Another Entry")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(
                                    LinearGradient(
                                        colors: [.teal, .mint],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: .teal.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            
                            Button(action: onDismiss) {
                                Text("Done")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(.teal)
                            }
                        }
                        
                        Spacer(minLength: 50)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        onDismiss()
                    }
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.teal)
                }
            }
        }
        .onAppear {
            showingConfetti = true
        }
    }
}

#Preview {
    SummaryView(
        entry: JournalEntry(
            id: UUID(),
            text: "Today I felt really grateful for the small moments of peace in my day. The morning coffee was perfect, and I took a few minutes to just breathe and appreciate the quiet.",
            date: Date(),
            detectedEmotion: "Grateful"
        ),
        onDismiss: {}
    )
}
