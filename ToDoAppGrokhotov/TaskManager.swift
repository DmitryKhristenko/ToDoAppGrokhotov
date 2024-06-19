//
//  TaskManager.swift
//  ToDoAppGrokhotov
//
//  Created by Дмитрий Х on 18.06.24.
//

import Foundation
import RealmSwift

// Manages the list of tasks and their saving/loading
final class TaskManager: ObservableObject {
    private var realm: Realm
    @Published var tasks: Results<Task>
    
    init() {
        do {
            realm = try Realm()
            // Loading all tasks from the Realm database
            tasks = realm.objects(Task.self)
        } catch let error {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Methods
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
        guard let thawedTask = task.thaw() else { print("ERROR in updateTask"); return }
        do {
            try realm.write {
                thawedTask.title = task.title
                thawedTask.taskDescription = task.taskDescription
                thawedTask.dueDate = task.dueDate
                thawedTask.isCompleted = task.isCompleted
            }
        } catch let error {
            print("Failed to update task: \(error.localizedDescription)")
        }
    }
    
    func deleteTask(task: Task) {
        guard let taskToDelete = realm.object(ofType: Task.self, forPrimaryKey: task.id) else {
            print("Task not found in Realm")
            return
        }
        do {
            try realm.write {
                realm.delete(taskToDelete)
            }
        } catch let error {
            print("Failed to delete task: \(error.localizedDescription)")
        }
    }
    
    // Changing the task completion status
    func toggleTaskCompletion(task: Task) {
        guard let thawedTask = task.thaw() else { return }
        do {
            try realm.write {
                thawedTask.isCompleted.toggle()
            }
        } catch let error {
            print("Failed to toggle task completion: \(error.localizedDescription)")
        }
    }
}
