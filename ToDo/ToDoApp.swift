//
//  ToDoApp.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import SwiftUI

@main
struct ToDoApp: App {
    let persistenceController = PersistenceController.shared

    @StateObject var listViewModel: ListViewModel
    
    init() {
        let context = persistenceController.container.viewContext
        let todoService = TodoService()
        _listViewModel = StateObject(wrappedValue: ListViewModel(todoService: todoService, viewContext: context))
        
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel(todoService: TodoService(), viewContext: PersistenceController.preview.container.viewContext))
}
