import SwiftUI

struct ProfileView: View {
    @StateObject private var dataManager = JournalDataManager.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.4),
                        Color.pink.opacity(0.1),
                        Color.mint.opacity(0.3)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.teal.opacity(0.3), .mint.opacity(0.2)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: "person.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.teal)
                            }
                            
                            Text("Your Mindful Journey")
                                .font(.system(size: 24, weight: .light, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text("Reflecting on life, one entry at a time")
                                .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        
                        // Stats Section
                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: "chart.bar.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(.teal)
                                
                                Text("Your Statistics")
                                    .font(.system(size: 20, weight: .light, design: .rounded))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 16) {
                                StatCard(
                                    title: "Total Entries",
                                    value: "\(dataManager.entries.count)",
                                    icon: "book.fill",
                                    color: .teal
                                )
                                
                                StatCard(
                                    title: "This Month",
                                    value: "\(entriesThisMonth)",
                                    icon: "calendar",
                                    color: .mint
                                )
                                
                                StatCard(
                                    title: "Streak",
                                    value: "\(currentStreak) days",
                                    icon: "flame.fill",
                                    color: .orange
                                )
                                
                                StatCard(
                                    title: "Most Common",
                                    value: mostCommonEmotion,
                                    icon: "face.smiling.fill",
                                    color: .blue
                                )
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
                        
                        VStack(spacing: 16) {
                            HStack {
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(.teal)
                                
                                Text("Settings")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            
                            VStack(spacing: 12) {
                                SettingsRow(
                                    icon: "bell.fill",
                                    title: "Daily Reminders",
                                    subtitle: "Get gentle reminders to journal"
                                )
                                
                                SettingsRow(
                                    icon: "moon.fill",
                                    title: "Mindful Mode",
                                    subtitle: "Enhanced focus experience"
                                )
                                
                                SettingsRow(
                                    icon: "lock.fill",
                                    title: "Privacy",
                                    subtitle: "Your entries are private"
                                )
                                
                                SettingsRow(
                                    icon: "heart.fill",
                                    title: "About",
                                    subtitle: "Learn more about mindful journaling"
                                )
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
                        
                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 45)
                }
            }
        }
    }
    
    private var entriesThisMonth: Int {
        let calendar = Calendar.current
        let now = Date()
        return dataManager.entries.filter { entry in
            calendar.isDate(entry.date, equalTo: now, toGranularity: .month)
        }.count
    }
    
    private var currentStreak: Int {
        guard !dataManager.entries.isEmpty else { return 0 }
        
        let sortedEntries = dataManager.entries.sorted { $0.date > $1.date }
        let calendar = Calendar.current
        var streak = 0
        var currentDate = Date()
        
        for entry in sortedEntries {
            if calendar.isDate(entry.date, inSameDayAs: currentDate) {
                streak += 1
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
            } else {
                break
            }
        }
        
        return streak
    }
    
    private var mostCommonEmotion: String {
        guard !dataManager.entries.isEmpty else { return "None" }
        
        let emotions = dataManager.entries.map { $0.detectedEmotion }
        let emotionCounts = Dictionary(grouping: emotions, by: { $0 })
            .mapValues { $0.count }
        
        return emotionCounts.max(by: { $0.value < $1.value })?.key ?? "None"
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            Text(title)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.teal)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ProfileView()
}
