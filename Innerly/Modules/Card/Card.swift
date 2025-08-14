//
//  Card.swift
//  Innerly
//
//  Created by Elisa Kalil on 08/08/2025.
//

import SwiftUI

struct JournalEntryCard: View {
    let entry: JournalEntry
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 16) {
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
                
                Text(entry.text)
                    .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
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
