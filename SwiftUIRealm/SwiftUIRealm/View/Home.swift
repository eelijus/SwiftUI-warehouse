//
//  Home.swift
//  SwiftUIRealm
//
//  Created by Suji Lee on 2022/09/13.
//

import SwiftUI
import RealmSwift

struct Home: View {
    //Fetch Data
    //Sorting by Date
    @ObservedResults(TaskItem.self, sortDescriptor: SortDescriptor.init(keyPath: "taskDate", ascending: false)) var tasksFetched
    
    //opening Keyboard for newly added task
    @State var lastAddedTaskID: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                if tasksFetched.isEmpty {
                    Text("Add some new Tasks!")
                        .font(.caption)
                } else {
                    List {
                        ForEach(tasksFetched) { task in
                            TaskRow(task: task, lastAddedTaskID: $lastAddedTaskID)
                            //Delete Data
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        $tasksFetched.remove(task)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .animation(.easeInOut, value: tasksFetched)
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                Button {
                    //Adding Task
                    let task = TaskItem()
                    lastAddedTaskID = task.id.stringValue
                    $tasksFetched.append(task)
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
            //Observing keyboard
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                
                lastAddedTaskID = ""
                guard let last = tasksFetched.last else {
                    return
                }
                if last.taskTitle == "" {
                    //removing task
                    $tasksFetched.remove(last)
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TaskRow: View {
    
    @ObservedRealmObject var task: TaskItem
    
    @Binding var lastAddedTaskID: String
    
    //Keyboard Focus
    @FocusState var showKeyboard: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            //Task Status Indicator Menu
            Menu {
                //update Data
                Button("Missed") {
                    $task.taskStatus.wrappedValue = .missed
                }
                Button("Completed") {
                    $task.taskStatus.wrappedValue = .completed
                }
            } label: {
                Circle()
                    .stroke(.gray)
                    .frame(width: 15, height: 15)
                    .overlay(
                        Circle()
                            .fill(task.taskStatus == .missed ? .red :
                                    (task.taskStatus == .pending ? .yellow : .green))
                    )
            }
            VStack(alignment: .leading, spacing: 12) {
                //Task Title
                TextField("sujileelea", text: $task.taskTitle)
                    .focused($showKeyboard)
                //Task Date
                if task.taskTitle != "" {
                    Picker(selection: .constant("")) {
                        DatePicker(selection: $task.taskDate, displayedComponents: .date) {
                            
                        }
                        .labelsHidden()
                        .navigationTitle("Task Date")
                    } label: {
                        HStack {
                            Image(systemName: "calendar")
                            Text(task.taskDate.formatted(date: .abbreviated, time: .omitted))
                        }
                    }
                }
            }
        }
        .onAppear {
            if lastAddedTaskID == task.id.stringValue {
                showKeyboard.toggle()
            }
        }
    }
}
