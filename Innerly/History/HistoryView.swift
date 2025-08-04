import SwiftUI

struct HistoryView: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 34, weight: .ultraLight),
            .foregroundColor: UIColor.label
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        HistoryContentView()
    }
}

struct HistoryContentView: View {
    @StateObject private var dataManager = JournalDataManager.shared
    @State private var selectedEntry: JournalEntry?
    @State private var showingDetail = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.05),
                        Color.yellow.opacity(0.1),
                        Color.pink.opacity(0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if dataManager.entries.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "book.closed.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.teal.opacity(0.3), .mint.opacity(0.9)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("No Entries Yet")
                            .font(.system(size: 24, weight: .ultraLight, design: .rounded))
                            .foregroundColor(.primary)
                        
                        Text("Start your mindful journey by\nwriting your first journal entry")
                            .font(.system(size: 16, weight: .light, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(dataManager.entries.sorted(by: { $0.date > $1.date })) { entry in
                                JournalEntryCard(entry: entry) {
                                    selectedEntry = entry
                                    showingDetail = true
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    }
                }
            }
            .navigationTitle("Your Journey")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showingDetail) {
            if let entry = selectedEntry {
                DetailView(entry: entry)
            }
        }
    }
}

struct JournalEntryCard: View {
    let entry: JournalEntry
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.teal)
                        
                        Text(entry.date.formatted(date: .omitted, time: .shortened))
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    // Emotion Badge
                    Text(entry.detectedEmotion)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.teal)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.teal.opacity(0.15))
                        )
                }
                
                // Entry Preview
                Text(entry.text)
                    .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                // Read More Indicator
                HStack {
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("Read more")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.teal)
                        
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.teal)
                    }
                }
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
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    HistoryView()
}
