//
//  TaskViewModel.swift
//  SampleRealm
//
//  Created by 渡邊魁優 on 2023/04/24.
//

import Foundation
import RealmSwift


class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var newTaskTitle: String = ""
    @Published var isAddView = false

    private var realm: Realm

    init() {
        realm = try! Realm()
        fetchTasks()
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
    }

    //Realmから[object]を取得
    private func fetchTasks() {
        tasks = Array(realm.objects(Task.self))
    }

    func addTask() {
        //入力されていないならreturn
        if newTaskTitle.isEmpty { return }

        let task = Task()
        task.title = newTaskTitle

        //Realmに追加
        try! realm.write {
            realm.add(task)
        }

        newTaskTitle = ""
        fetchTasks()
    }

    func deleteTask(at offsets: IndexSet) {
        let tasksToDelete = offsets.map { tasks[$0] }
        try! realm.write {
            realm.delete(tasksToDelete)
        }
        fetchTasks()
    }
    
    func didTapPlusView() {
        isAddView = true
    }
    
    func didTapAddViewCancelButton() {
        isAddView = false
    }
    
    func didTapAddViewSaveButton(text: String) {
        newTaskTitle = text
        addTask()
        isAddView = false
    }
}
