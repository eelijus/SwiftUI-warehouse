//
//  TaskModel.swift
//  NTDARealm
//
//  Created by Suji Lee on 2022/09/13.
//

import Foundation
import RealmSwift

class TaskModel: Object, Identifiable {
    @Persisted var taskTitle: String
    @Persisted var taskDescription: String = ""
    @Persisted var taskDate: Date = Date()
    @Persisted var descriptionVisibility: Bool = true
    @Persisted var isCompleted: Bool = false

}
