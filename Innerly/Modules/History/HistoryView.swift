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
    @StateObject private var viewModel = HistoryViewModel()

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

                if viewModel.hasEntries {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.entries) { entry in
                                JournalEntryCard(entry: entry) {
                                    viewModel.selectEntry(entry)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    }
                } else {
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
                }
            }
            .navigationTitle("Your Journey")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(item: $viewModel.selectedEntry) { entry in
            DetailView(entry: entry)
        }
    }
}
