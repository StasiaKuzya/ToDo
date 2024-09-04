//
//  EmptyListView.swift
//  ToDo
//
//  Created by Анастасия on 03.09.2024.
//

import SwiftUI

struct EmptyListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var isAnimation = false
    
    var body: some View {
            VStack(spacing: 20) {
                Spacer()
                Text("There is nothing to do!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                
                Text("Add something\nStay productive all day long!")
                    .padding(.bottom, 20)
                NavigationLink(
                    destination: AddView()
                ) {
                    Text("Add new ToDo 🎯")
                        .foregroundStyle(.white).bold()
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .background(isAnimation ? .mint : .teal)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .offset(y: isAnimation ? -7 : 0)
                        .scaleEffect(isAnimation ? 1.12 : 1.0)
                }
                .padding(.horizontal, isAnimation ? 10 : 20)
                .shadow(
                    color: isAnimation ? .teal.opacity(0.5) : .mint.opacity(0.5),
                    radius: isAnimation ? 20 : 10,
                    y: isAnimation ? 30 : 10
                )
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 30)
            .multilineTextAlignment(.center)
            .onAppear(perform: startAnimation)
    }
        
    private func startAnimation() {
        guard !isAnimation else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut(duration: 2).repeatForever()) {
                isAnimation.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack {
        EmptyListView()
            .navigationTitle("ToDo List 🚀")
    }
    .environmentObject(ListViewModel(todoService: TodoService()))
}
