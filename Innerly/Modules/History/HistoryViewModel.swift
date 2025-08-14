//
//  HistoryViewModel.swift
//  Innerly
//
//  Created by Elisa Kalil on 08/08/2025.
//

import SwiftUI
import Combine

final class HistoryViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []
    @Published var selectedEntry: JournalEntry?

    private var cancellables = Set<AnyCancellable>()
    private let dataManager = JournalDataManager.shared

    init() {
        dataManager.$entries
            .map { $0.sorted(by: { $0.date > $1.date }) }
            .assign(to: &$entries)
    }

    func selectEntry(_ entry: JournalEntry) {
        selectedEntry = entry
    }

    func clearSelection() {
        selectedEntry = nil
    }

    var hasEntries: Bool {
        !entries.isEmpty
    }
}
