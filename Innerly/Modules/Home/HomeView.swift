import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.red.opacity(0.1),
                        Color.teal.opacity(0.15),
                        Color.mint.opacity(0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        VStack(spacing: 16) {
                            Image(systemName: "heart.circle.fill")
                                .font(.system(size: 50))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.teal, .mint],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            
                            Text("Welcome to Your\nMindful Space")
                                .font(.system(size: 32, weight: .ultraLight, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.primary)
                            
                            Text("Take a moment to reflect on your thoughts and feelings")
                                .font(.system(size: 16, weight: .light, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                        }
                        .padding(.top, 45)
                        
                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: "applepencil.and.scribble")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.teal)
                                
                                Text("How are you feeling today?")
                                    .font(.system(size: 18, weight: .light, design: .rounded))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            
                            ZStack(alignment: .topLeading) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
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
                                
                                TextEditor(text: $viewModel.journalText)
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .padding(20)
                                    .background(Color.clear)
                                    .focused($isTextFieldFocused)
                                    .scrollContentBackground(.hidden)
                                
                                if viewModel.journalText.isEmpty && !viewModel.isTextFieldFocused {
                                    Text("Share your thoughts, feelings, or experiences...")
                                        .font(.system(size: 16, weight: .light, design: .rounded))
                                        .foregroundColor(.secondary)
                                        .padding(.horizontal, 24)
                                        .padding(.top, 28)
                                        .allowsHitTesting(false)
                                }
                            }
                            .frame(minHeight:  UIScreen.main.bounds.height * 0.36)
                            
                            Button {
                                viewModel.submitEntry()
                            } label: {
                                Text("Reflect & Save")
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                            
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
                            .disabled(viewModel.journalText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                            .opacity(viewModel.journalText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer(minLength: 100)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(item: $viewModel.currentEntry) { entry in
            SummaryView(entry: entry, onDismiss: {
                viewModel.clearAndClose()
            })
        }
    }
}

#Preview {
    HomeView()
}
