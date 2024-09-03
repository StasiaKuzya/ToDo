//
//  ListViewModel.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import Foundation

enum UserDefaultsKeys {
    static let itemList = "item_list"
}

final class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveData()
        }
    }
    
    init() {
        getData()
    }
    
    //MARK: Public Methods
    func getData() {
        guard
            let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.itemList),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        items = savedItems
    }
    
    func deleteItem(index: IndexSet) {
        items.remove(atOffsets: index)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        items.append(.init(title: title, isCompleted: false))
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveData() {
        guard let encodedData = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsKeys.itemList)
    }
}
