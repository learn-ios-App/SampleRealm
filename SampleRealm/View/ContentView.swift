//
//  ContentView.swift
//  SampleRealm
//
//  Created by 渡邊魁優 on 2023/04/24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.tasks, id: \.id) { task in
                        ListRow(task: task)
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("ToDoリスト")
            .toolbar {
                ToolbarItem() {
                    Button(action: {
                        viewModel.didTapPlusView()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isAddView) {
            AddTaskView(save: { text in
                viewModel.didTapAddViewSaveButton(text: text)
            }, cancel: {
                viewModel.didTapAddViewCancelButton()

            }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
