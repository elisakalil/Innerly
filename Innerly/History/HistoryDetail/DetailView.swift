import SwiftUI

struct DetailView: View {
    let entry: JournalEntry
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(
                    colors: [
                        Color.mint.opacity(0.15),
                        Color.teal.opacity(0.1),
                        Color.blue.opacity(0.05)
                    ],
                    center: .center,
                    startRadius: 100,
                    endRadius: 500
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(entry.date.formatted(date: .complete, time: .omitted))
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                        .foregroundColor(.primary)
                                    
                                    Text(entry.date.formatted(date: .omitted, time: .shortened))
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            
                            HStack {
                                Image(systemName: "face.smiling.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.teal)
                                
                                Text("Feeling: \(entry.detectedEmotion)")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.teal)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.teal.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.teal.opacity(0.3), lineWidth: 1)
                                    )
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "quote.opening")
                                    .font(.system(size: 16))
                                    .foregroundColor(.teal)
                                
                                Text("Your Reflection")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            
                            Text(entry.text)
                                .font(.system(size: 17, weight: .regular, design: .rounded))
                                .foregroundColor(.primary)
                                .lineSpacing(4)
                        }
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    LinearGradient(
                                        colors: [.teal.opacity(0.2), .mint.opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                        
                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Journal Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.teal)
                }
            }
        }
    }
}

#Preview {
    DetailView(
        entry: JournalEntry(
            id: UUID(),
            text: "Today was a beautiful day filled with small moments of joy. I took a walk in the park and noticed how the sunlight filtered through the leaves. It reminded me to slow down and appreciate the present moment. I'm grateful for these peaceful times that help me reconnect with myself.",
            date: Date(),
            detectedEmotion: "Grateful"
        )
    )
}
