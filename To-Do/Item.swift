//
//  Item.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/13.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
