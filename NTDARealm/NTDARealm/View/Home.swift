//
//  Home.swift
//  NTDARealm
//
//  Created by Suji Lee on 2022/09/13.
//

import SwiftUI
import RealmSwift

struct Home: View {
    
    @ObservedResults(TaskModel.self, sortDescriptor: SortDescriptor.init(keyPath: "taskDate", ascending: false)) var taskModel
    @ObservedRealmObject var dateModel: DateModel
    
    @State private var showModal = false
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                if let filtered = dateModel.filteredTasks {
                    if filtered.isEmpty {
                        NoTaskView()
                    }
                    else {
                        List {
                            Section {
                                ForEach(filtered) { task in
                                    if !task.isComplete {
                                        TaskCardView()
                                            .swipeActions(edge: .leading) {
                                                Button (action: {
                                                    //code
                                                }) {
                                                    Label("Done", systemImage: "checkmark")
                                                }
                                                .tint(.green)
                                            }
                                        
                                            .onTapGesture {
                                                self.showModal = true
                                            }
                                            .swipeActions {
                                                Button(role: .destructive) {
                                                    withAnimation(.linear(duration: 0.4)) {
                                                        //delete code
                                                        print("delete")
                                                    }
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                            }
                                    }
                                }

                                .sheet(isPresented: self.$showModal) {
                                    ModalView()
                                }
                            }
                            
                            Section {
                                ForEach(filtered) { task in
                                    if task.isComplete {
                                        TaskDoneCardView()
//                                            .onChange(of: taskViewModel.currentDay) { newValue in
//                                                taskViewModel.filterTodayTasks()
//                                            }
                                            .onTapGesture {
                                                self.showModal = true
                                            }
                                            .swipeActions {
                                                Button(role: .destructive) {
                                                    withAnimation(.linear(duration: 0.4)) {

                                                        //delete code
                                                        print("delete")
                                                    }
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                            }
                                    }
                                }
                                .sheet(isPresented: self.$showModal) {
                                    ModalView()
                                }
                            }
                        }
                        .frame(minHeight: 500)
                        .background(Color.yellow)
                    }
                }
            }
            .navigationTitle("TASKS")
            .navigationBarItems(trailing: NavigationLink("Calendar", destination: CalendarView()))
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                self.showModal = true
            } label: {
                Text("+")
                    .foregroundColor(.purple)
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity)
            }
            .sheet(isPresented: self.$showModal) {
                ModalView()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .background(.ultraThinMaterial)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(dateModel: DateModel())
    }
}
