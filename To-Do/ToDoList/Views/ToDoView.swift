//
//  ToDoView.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/13.
//

import SwiftUI
import SwiftData

struct ToDoView: View {
    @State private var isShowingCreateToDo = false
    @State private var isShowingWeather = false
    
    private func addItem() {
        isShowingCreateToDo.toggle()
    }
    
    private func displayWeather() {
        isShowingWeather.toggle()
    }
       
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("To Dos")) {
                    ToDoListView(isCompleted: false)
                }
                Section(header: Text("Completed")) {
                    ToDoListView(isCompleted: true)
                }
            }
            .sheet(isPresented: $isShowingCreateToDo) { CreateToDoView() }
            .sheet(isPresented: $isShowingWeather) { WeatherView() }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: displayWeather) {
                        Label("Show Weather", systemImage: "cloud.drizzle")
                    }
                }
            }
        }
    }
}

#Preview {
    ToDoView().modelContainer(for: ToDoItem.self, inMemory: true)
}
