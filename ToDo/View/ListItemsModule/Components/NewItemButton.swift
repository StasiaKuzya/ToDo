//
//  NewItemButton.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import SwiftUI

struct NewItemButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.orange)
            .frame(maxWidth: 68, maxHeight: 68)
            .shadow(color: .purple.opacity(0.8), radius: 12)
            .overlay {
                Image(systemName: "plus.square.fill")
                    .foregroundStyle(.white)
                    .imageScale(.large)
            }
    }
}

#Preview {
    NewItemButton()
}
