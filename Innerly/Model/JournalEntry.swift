import Foundation

struct JournalEntry: Identifiable, Codable {
    let id: UUID
    let text: String
    let date: Date
    let detectedEmotion: String
    
    init(id: UUID = UUID(), text: String, date: Date = Date(), detectedEmotion: String) {
        self.id = id
        self.text = text
        self.date = date
        self.detectedEmotion = detectedEmotion
    }
}