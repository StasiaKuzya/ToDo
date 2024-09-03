//
//  ItemModel.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    //MARK: Mock Data
    static let mockItemCompleted: ItemModel = .init(title: "Mock item 1", isCompleted: true)
    static let mockItem: ItemModel = .init(title: "Mock item 2", isCompleted: false)
    
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
