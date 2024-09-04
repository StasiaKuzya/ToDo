//
//  ListViewModel.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import Foundation
import CoreData
import SwiftUI

enum UserDefaultsKeys {
    static let itemList = "item_list"
}

final class ListViewModel: ObservableObject {
    @Published var items: [Todo] = [] {
        didSet {
            saveData()
        }
    }
    
    private let todoService: TodoService
    
    init(todoService: TodoService) {
        self.todoService = todoService
        fetchTodos()
    }
    
    //MARK: Public Methods
    func getData() {
        guard
            let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.itemList),
            let savedItems = try? JSONDecoder().decode([Todo].self, from: data)
        else {
            fetchTodos()
            return
        }
        items = savedItems
    }
    
    func fetchTodos() {
        todoService.fetchTodos { [weak self] fetchedItems in
            self?.items = fetchedItems
        }
    }
    
    func deleteItem(index: IndexSet) {
        items.remove(atOffsets: index)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = Todo(id: items.count + 1, title: title, completed: false, userID: 0)
        items.append(newItem)
    }
    
    func updateItem(item: Todo) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveData() {
        guard let encodedData = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsKeys.itemList)
    }
}
