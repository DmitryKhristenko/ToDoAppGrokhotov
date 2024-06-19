//
//  TaskListView.swift
//  ToDoAppGrokhotov
//
//  Created by Дмитрий Х on 18.06.24.
//

import SwiftUI
import RealmSwift

enum TaskStatus: String, CaseIterable {
    case allTasks
    case completed
    case incomplete
}

struct TaskListView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var selectedFilter: TaskStatus = .allTasks
    @ObservedResults(Task.self) var tasks
    
    var filteredTasks: Results<Task> {
        switch selectedFilter {
        case .allTasks:
            return tasks
        case .completed:
            return tasks.filter("isCompleted == true")
        case .incomplete:
            return tasks.filter("isCompleted == false")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Filter", selection: $selectedFilter) {
                    Text("All").tag(TaskStatus.allTasks)
                    Text("Completed").tag(TaskStatus.completed)
                    Text("Incomplete").tag(TaskStatus.incomplete)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    ForEach(filteredTasks) { task in
                        NavigationLink(destination: TaskDetailView(taskManager: taskManager, task: task)) {
                            TaskRow(task: task, taskManager: taskManager)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .navigationTitle("To-Do List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: TaskDetailView(taskManager: taskManager, task: nil)) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = filteredTasks[index]
            taskManager.deleteTask(task: task)
        }
    }
}


#Preview {
    TaskListView()
}
