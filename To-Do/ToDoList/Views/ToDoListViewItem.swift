//
//  ToDoListViewItem.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/15.
//

import SwiftUI

struct ToDoListViewItem: View {
    var toDoItem: ToDoItem
    
    private func toggleCompletion() {
        toDoItem.completed.toggle()
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(toDoItem.title)
                    .font(.headline)
                
                Text(toDoItem.detail)
                    .font(.caption)
            }
            
            Spacer()
            
            if toDoItem.completed {
                Image(systemName: "checkmark").foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    ToDoListViewItem(toDoItem: ToDoItem(title: "Test", detail: "Test", completed: false))
}
