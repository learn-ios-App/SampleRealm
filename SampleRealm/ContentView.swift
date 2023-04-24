//
//  ContentView.swift
//  SampleRealm
//
//  Created by 渡邊魁優 on 2023/04/24.
//

import SwiftUI
import Foundation
import RealmSwift


class Task: Object, Identifiable {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var isCompleted: Bool = false

    override static func primaryKey() -> String? {
        return "id"
    }
}

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.tasks) { task in
                        TaskRowView(task: task)
                            .onTapGesture {
                                viewModel.toggleCompletion(task: task)
                            }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
                .listStyle(PlainListStyle())

                HStack {
                    TextField("新しいタスク", text: $viewModel.newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: viewModel.addTask) {
                        Text("追加")
                    }
                }
                .padding()
            }
            .navigationTitle("ToDoリスト")
            .toolbar {
                EditButton()
            }
        }
    }
}

struct TaskRowView: View {
    let task: Task

    var body: some View {
        HStack {
            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundColor(task.isCompleted ? .gray : .primary)

            Spacer()

            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
    }
}

class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: Results<Task>
    @Published var newTaskTitle: String = ""

    private var realm: Realm

    init() {
        realm = try! Realm()
        tasks = realm.objects(Task.self)
    }

    func addTask() {
        if newTaskTitle.isEmpty { return }

        let task = Task()
        task.title = newTaskTitle

        try! realm.write {
            realm.add(task)
        }

        newTaskTitle = ""
    }

    func deleteTask(at offsets: IndexSet) {
        let tasksToDelete = offsets.map { tasks[$0] }
        try! realm.write {
            realm.delete(tasksToDelete)
        }
    }

    func toggleCompletion(task: Task) {
        try! realm.write {
            task.isCompleted.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
