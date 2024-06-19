//
//  TaskRow.swift
//  ToDoAppGrokhotov
//
//  Created by Дмитрий Х on 18.06.24.
//

import SwiftUI

struct TaskRow: View {
    // MARK: - Properties
    var task: Task
    @ObservedObject var taskManager: TaskManager
    
    // MARK: - Body
    var body: some View {
        HStack {
            Button(action: {
                taskManager.toggleTaskCompletion(task: task.thaw()!)
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .red)
            }
            .buttonStyle(BorderlessButtonStyle()) /// This is important for the click ability inside the List
            
            Text(task.title)
                .padding(.leading, 10)
            Spacer()
        }
    }
}
