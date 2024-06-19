//
//  TaskManager.swift
//  ToDoAppGrokhotov
//
//  Created by Дмитрий Х on 18.06.24.
//

import RealmSwift
import Foundation

// Manages the list of tasks and their saving/loading
final class TaskManager: ObservableObject {
    private var realm: Realm
    @Published var tasks: Results<Task>
    
    init() {
        do {
            realm = try Realm()
            tasks = realm.objects(Task.self)
        } catch let error {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    func addTask(_ task: Task) {
        do {
            try realm.write {
                realm.add(task)
            }
        } catch let error {
            print("Failed to add task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task) {
        do {
            try realm.write {
                realm.add(task, update: .modified)
            }
        } catch let error {
            print("Failed to update task: \(error.localizedDescription)")
        }
    }
    
    func deleteTask(task: Task) {
        do {
            try realm.write {
                if let taskToDelete = realm.object(ofType: Task.self, forPrimaryKey: task.id) {
                    realm.delete(taskToDelete)
                }
            }
        } catch let error {
            print("Failed to delete task: \(error.localizedDescription)")
        }
    }
    
    func toggleTaskCompletion(task: Task) {
        do {
            try realm.write {
                task.isCompleted.toggle()
            }
        } catch let error {
            print("Failed to toggle task completion: \(error.localizedDescription)")
        }
    }
}
