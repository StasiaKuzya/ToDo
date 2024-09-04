//
//  AddView.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var viewModel: ListViewModel
    @Environment(\.dismiss) var dismiss
    @State private var itemText: String = ""
    @State private var alertTitle: String = ""
    @State private var isShowAlert: Bool = false
    @FocusState var isFocus: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .blue.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                TextField("📍Type something here...", text: $itemText)
                    .padding(12)
                    .background(.white.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 20)
                    .focused($isFocus)
                    .onSubmit { saveNewItem() }
                    .submitLabel(.done)
                
                
                Button {
                    saveNewItem()
                } label: {
                    Text("Save".uppercased())
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(.mint)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Spacer()
            }
            .padding(.horizontal, 14)
            .navigationTitle("Add new item 🖇️")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left.2")
                            .foregroundStyle(.white)
                    }
                }
            }
            .alert(isPresented: $isShowAlert) { getAlert() }
            .onAppear { isFocus = true }
        }
    }
    
    //MARK: Private Methods
    private func saveNewItem() {
        guard validateTextFiled() else { return }
        viewModel.addItem(title: itemText)
        dismiss()
    }
    
   private func validateTextFiled() -> Bool {
        if itemText.count >= 3 {
            return true
        } else {
            alertTitle = "The item must be at least 3 letters🤌"
            isShowAlert.toggle()
            return false
        }
    }
    
    private func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

#Preview {
    NavigationView {
        AddView()
    }
    .environmentObject(ListViewModel(todoService: TodoService()))
}
