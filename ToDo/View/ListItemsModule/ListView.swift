//
//  ContentView.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import SwiftUI
import CoreData

struct ListView: View {
    @EnvironmentObject var viewModel: ListViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .blue.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            
            if viewModel.items.isEmpty {
                EmptyListView().transition(.opacity.animation(.easeInOut))
                    .foregroundStyle(.white)
            } else {
                List {
                    ForEach(viewModel.items) { item in
                        Button {
                            withAnimation(.easeInOut) {
                                viewModel.updateItem(item: item)
                            }
                        } label: {
                            ListRowItem(item: item)
                        }
                    }
                    .onDelete(perform: viewModel.deleteItem)
                    .onMove(perform: viewModel.moveItem)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .padding(.top, 1)
            }
            
            if !viewModel.items.isEmpty {
                NavigationLink {
                    AddView()
                } label: {
                    NewItemButton()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.trailing)
            }
        }
        .navigationTitle("ToDo List 🚀")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddView()
                } label: {
                    Image(systemName: "plus.app").foregroundStyle(.white)
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                EditButton().foregroundStyle(.white)
            }
        }
        .tint(.indigo)
    }
}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel(todoService: TodoService(), viewContext: PersistenceController.preview.container.viewContext))
}
