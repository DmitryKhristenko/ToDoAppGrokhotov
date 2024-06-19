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
    @State private var showAlert: Bool = false
    @Environment(\.dismiss) private var dismiss
    
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
        .navigationTitle(task.realm == nil ? "New Task" : "Edit Task")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if task.realm == nil {
                    Button("Save") {
                        if task.title.isEmpty {
                            showAlert = true
                        } else {
                            saveTask()
                            dismiss()
                        }
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Task title cannot be empty"), dismissButton: .default(Text("OK")))
        }
    }
    
    private func saveTask() {
        if task.realm == nil {
            taskManager.addTask(task)
        } else {
            taskManager.updateTask(task)
        }
    }
}

#Preview {
    TaskDetailView(taskManager: TaskManager(), task: Task())
}
