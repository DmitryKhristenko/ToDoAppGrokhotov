//
//  TaskModel.swift
//  ToDoAppGrokhotov
//
//  Created by Дмитрий Х on 18.06.24.
//

import RealmSwift
import Foundation

// Task Data Model for Realm
final class Task: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var taskDescription = ""
    // Date of completion of the task
    @objc dynamic var dueDate = Date()
    @objc dynamic var isCompleted = false
    // Setting the id as the primary key
    override static func primaryKey() -> String? {
        return "id"
    }
}
