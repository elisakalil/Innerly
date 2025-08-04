import Foundation
import Combine

class JournalDataManager: ObservableObject {
    static let shared = JournalDataManager()
    
    @Published var entries: [JournalEntry] = []
    
    private let userDefaults = UserDefaults.standard
    private let entriesKey = "journalEntries"
    
    private init() {
        loadEntries()
    }
    
    func addEntry(_ entry: JournalEntry) {
        entries.append(entry)
        saveEntries()
    }
    
    func deleteEntry(_ entry: JournalEntry) {
        entries.removeAll { $0.id == entry.id }
        saveEntries()
    }
    
    func updateEntry(_ entry: JournalEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
            saveEntries()
        }
    }
    
    private func saveEntries() {
        do {
            let data = try JSONEncoder().encode(entries)
            userDefaults.set(data, forKey: entriesKey)
        } catch {
            print("Failed to save entries: \(error)")
        }
    }
    
    private func loadEntries() {
//        emptySampleData()
        guard let data = userDefaults.data(forKey: entriesKey) else {
            // Load sample data for preview
           loadSampleData()
            return
        }
        
        do {
            entries = try JSONDecoder().decode([JournalEntry].self, from: data)
        } catch {
            print("Failed to load entries: \(error)")
            loadSampleData()
        }
    }
    
    private func loadSampleData() {
        entries = [
            JournalEntry(
                text: "Today I felt really grateful for the small moments of peace in my day. The morning coffee was perfect, and I took a few minutes to just breathe.",
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
                detectedEmotion: "Grateful"
            ),
            JournalEntry(
                text: "Had a challenging day at work, but I'm learning to see obstacles as opportunities for growth. Taking deep breaths helps me stay centered.",
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
                detectedEmotion: "Reflective"
            ),
            JournalEntry(
                text: "Spent time in nature today. The fresh air and sunshine reminded me how important it is to disconnect from technology and reconnect with myself.",
                date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
                detectedEmotion: "Peaceful"
            )
        ]
    }
    private func emptySampleData() {
        entries = []
    }
}
