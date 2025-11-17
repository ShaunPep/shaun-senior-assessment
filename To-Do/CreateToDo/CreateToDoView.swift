//
//  CreateToDoView.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/15.
//

import SwiftUI

struct CreateToDoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var detail: String = ""
    
    private func saveNewToDo() {
        let newToDo = ToDoItem(title: title, detail: detail, completed: false)
        modelContext.insert(newToDo)
        
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Detail", text: $detail)
            }
            .navigationTitle("New To Do")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        saveNewToDo()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateToDoView()
}
