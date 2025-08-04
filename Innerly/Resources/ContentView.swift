import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Home")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("History")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(.teal)
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
