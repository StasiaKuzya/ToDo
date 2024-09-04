//
//  ListViewModel.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import Foundation
import CoreData
import SwiftUI

final class ListViewModel: ObservableObject {
    @Published var items: [Todo] = []
    private let todoService: TodoService
    private let viewContext: NSManagedObjectContext

    init(todoService: TodoService, viewContext: NSManagedObjectContext) {
        self.todoService = todoService
        self.viewContext = viewContext
        loadTodosFromCoreData()
        fetchTodosFromNetwork()
    }

    // MARK: - Core Data Methods
    func loadTodosFromCoreData() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let savedTodos = try viewContext.fetch(request)
            self.items = savedTodos.map { Todo(id: Int($0.id), title: $0.title ?? "", completed: $0.completed, userID: Int($0.userID)) }
        } catch {
            print("Failed to fetch todos from Core Data: \(error)")
        }
    }

    func saveTodoToCoreData(_ todo: Todo) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", todo.id)
        
        do {
            let fetchedTodos = try viewContext.fetch(request)
            
            if let todoEntity = fetchedTodos.first {
                todoEntity.title = todo.title
                todoEntity.completed = todo.completed
            } else {
                let newTodoEntity = Item(context: viewContext)
                newTodoEntity.id = Int64(todo.id)
                newTodoEntity.title = todo.title
                newTodoEntity.completed = todo.completed
                newTodoEntity.userID = Int64(todo.userID)
            }
            
            saveContext()
        } catch {
            print("Failed to save or update todo in Core Data: \(error)")
        }
    }

    func updateTodoInCoreData(_ todo: Todo) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", todo.id)

        do {
            let fetchedTodos = try viewContext.fetch(request)
            if let todoEntity = fetchedTodos.first {
                todoEntity.completed = todo.completed
                todoEntity.title = todo.title
                saveContext()
            }
        } catch {
            print("Failed to update todo in Core Data: \(error)")
        }
    }

    func deleteTodoFromCoreData(_ todo: Todo) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", todo.id)

        do {
            let fetchedTodos = try viewContext.fetch(request)
            if let todoEntity = fetchedTodos.first {
                viewContext.delete(todoEntity)
                saveContext()
            }
        } catch {
            print("Failed to delete todo from Core Data: \(error)")
        }
    }

    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }

    // MARK: - Network Methods
    func fetchTodosFromNetwork() {
        todoService.fetchTodos { [weak self] fetchedItems in
            guard let self = self else { return }

            for todo in fetchedItems {
                if !self.items.contains(where: { $0.id == todo.id }) {
                    self.saveTodoToCoreData(todo)
                }
            }

            self.loadTodosFromCoreData()
        }
    }

    // MARK: - Public Methods
    func addItem(title: String) {
        let newTodo = Todo(id: items.count + 1, title: title, completed: false, userID: 0)
        items.append(newTodo)
        saveTodoToCoreData(newTodo)
    }

    func updateItem(item: Todo) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
            updateTodoInCoreData(items[index])
        }
    }

    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let todo = items[index]
            deleteTodoFromCoreData(todo)
        }
        items.remove(atOffsets: offsets)
    }

    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
}
