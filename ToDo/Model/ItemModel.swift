//
//  ItemModel.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import Foundation
//
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

// MARK: - TaskEntity
struct TaskEntity: Codable {
    let todos: [Todo]
    let total, skip, limit: Int
}

// MARK: - Todo
struct Todo: Codable {
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

//import Foundation
//import CoreData
//
//@objc(Item)
//public class Item: NSManagedObject {
//    @NSManaged public var id: Int64
//    @NSManaged public var title: String
//    @NSManaged public var completed: Bool
//    @NSManaged public var timestamp: Date?
//}
