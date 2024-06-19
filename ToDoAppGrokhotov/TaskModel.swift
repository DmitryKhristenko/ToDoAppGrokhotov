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
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String = ""
    @Persisted var taskDescription: String = ""
    @Persisted var dueDate: Date = Date()
    @Persisted var isCompleted: Bool = false
}
