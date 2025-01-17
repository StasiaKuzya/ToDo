//
//  ItemModel.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import Foundation

// MARK: - TaskEntity
struct TaskEntity: Codable {
    let todos: [Todo]
    let total, skip, limit: Int
}

// MARK: - Todo
struct Todo: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let completed: Bool
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title = "todo"
        case completed
        case userID = "userId"
    }
    
    func updateCompletion() -> Todo {
        return Todo(id: id, title: title, completed: !completed, userID: 0)
    }
    
    //MARK: Mock Data
    static let mockItemCompleted: Todo = .init(id: 1, title: "Mock item 1", completed: true, userID: 123)
    static let mockItem: Todo = .init(id: 2, title: "Mock item 2", completed: false, userID: 124)
}
