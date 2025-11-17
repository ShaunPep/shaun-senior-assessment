//
//  ToDoItem.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/13.
//

import Foundation
import SwiftData

@Model
final class ToDoItem {
    var title: String
    var detail: String
    var completed: Bool
    
    init(title: String, detail: String, completed: Bool) {
        self.title = title
        self.detail = detail
        self.completed = completed
    }
}
