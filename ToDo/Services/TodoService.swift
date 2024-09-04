//
//  TodoService.swift
//  ToDo
//
//  Created by Анастасия on 04.09.2024.
//

import Foundation
import Combine

final class TodoService {
    private var cancellables = Set<AnyCancellable>()
    
    func fetchTodos(completion: @escaping ([ItemModel]) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TaskEntity.self, decoder: JSONDecoder())
            .map { $0.todos.map { ItemModel(id: String($0.id), title: $0.title, isCompleted: $0.completed) } }  // Преобразование Todo в ItemModel
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                case .failure(let error):
                    print("Error fetching todos: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { items in
                completion(items)
            })
            .store(in: &cancellables)
    }
}
