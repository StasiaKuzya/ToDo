//
//  ListRowView.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import SwiftUI

struct ListRowItem: View {
    var item: Todo
    
    var body: some View {
        HStack {
            Image(systemName: item.completed ? "checkmark.square.fill" : "square")
                .resizable().frame(width: 40, height: 40)
                .foregroundStyle(.orange)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .strikethrough(item.completed)
                    .lineLimit(1)
                Text("\(item.timestamp, formatter: itemFormatter)")
                    .font(.caption2)
            }
            .foregroundStyle(item.completed ? .white.opacity(0.5) : .white)
            Spacer()
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .font(.title2)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: [.mint, .cyan, .teal], startPoint: .topTrailing, endPoint: .bottomLeading))
        )
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

#Preview {
    VStack(alignment: .leading, spacing: 15) {
        ListRowItem(item: Todo.mockItemCompleted)
        ListRowItem(item: Todo.mockItem)
    }
}
