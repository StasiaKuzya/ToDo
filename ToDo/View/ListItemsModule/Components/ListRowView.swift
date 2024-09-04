//
//  ListRowView.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import SwiftUI

struct ListRowItem: View {
    var item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                .resizable().frame(width: 40, height: 40)
                .foregroundStyle(item.isCompleted ? .orange.opacity(0.8) : .orange)
            
            Text(item.title)
                .foregroundStyle(item.isCompleted ? .white.opacity(0.5) : .white)
                .strikethrough(item.isCompleted)
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
}

#Preview {
    VStack(alignment: .leading, spacing: 15) {
        ListRowItem(item: ItemModel.mockItemCompleted)
        ListRowItem(item: ItemModel.mockItem)
    }
}
