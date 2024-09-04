//
//  ToDoApp.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import SwiftUI

@main
struct ToDoApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel(todoService: TodoService())
    
    init() {
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
        }
    }
}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel(todoService: TodoService()))
}
