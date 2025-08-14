//
//  HomeViewModel.swift
//  Innerly
//
//  Created by Elisa Kalil on 08/08/2025.
//
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var journalText = ""
    @Published var currentEntry: JournalEntry?
    @Published var isTextFieldFocused = false
    
    func submitEntry() {
        let entry = JournalEntry(
            id: UUID(),
            text: journalText,
            date: Date(),
            detectedEmotion: "Peaceful"
        )
        
        currentEntry = entry
        JournalDataManager.shared.addEntry(entry)
        isTextFieldFocused = false
    }
    
    func clearAndClose() {
        journalText = ""
        currentEntry = nil
    }
}
