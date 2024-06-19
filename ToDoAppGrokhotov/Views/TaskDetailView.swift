//
//  TaskDetailView.swift
//  ToDoAppGrokhotov
//
//  Created by Дмитрий Х on 18.06.24.
//

import SwiftUI

struct TaskDetailView: View {
    // MARK: - Properties
    @ObservedObject var taskManager: TaskManager
    @State private var task: Task
    @Environment(\.presentationMode) var presentationMode
    
    init(taskManager: TaskManager, task: Task?) {
        self.taskManager = taskManager
        _task = State(initialValue: task ?? Task())
    }
    
    // MARK: - Body
    var body: some View {
        Form {
            Section(header: Text("Task Info")) {
                TextField("Title", text: $task.title)
                TextField("Description", text: $task.taskDescription)
                DatePicker("Due Date", selection: $task.dueDate, displayedComponents: .date)
            }
        }
        .navigationTitle(task.id.isEmpty ? "New Task" : "Edit Task")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveTask()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func saveTask() {
        if task.id.isEmpty {
            taskManager.addTask(task)
        } else {
            taskManager.updateTask(task)
        }
    }
}

#Preview {
    TaskDetailView(taskManager: TaskManager(), task: Task())
}
