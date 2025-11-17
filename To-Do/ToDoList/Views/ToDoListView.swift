//
//  ToDoListView.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/13.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var toDoItems: [ToDoItem]
    
    init(isCompleted: Bool) {
        _toDoItems = Query(filter: #Predicate<ToDoItem> { $0.completed == isCompleted })
    }
    
    private func removeItem(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(toDoItems[index])
            }
        }
    }
    
    var body: some View {
        ForEach(toDoItems) { item in
            ToDoListViewItem(toDoItem: item)
                .contentShape(Rectangle())
                .onTapGesture {
                item.completed.toggle()
            }
        }
        .onDelete(perform: removeItem)
    }
}

#Preview {
    ToDoListView(isCompleted: false)
}
