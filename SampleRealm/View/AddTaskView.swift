//
//  AddTaskView.swift
//  SampleRealm
//
//  Created by 渡邊魁優 on 2023/04/25.
//

import SwiftUI

struct AddTaskView: View {
    @State var text: String = ""
    let save: (String) -> Void
    let cancel: () -> Void
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("タスクを入力")
                TextField("", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 150)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        save(text)
                    }) {
                        Text("保存")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        cancel()
                    }) {
                        Text("戻る")
                    }
                }
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(save: { _ in }, cancel: {})
    }
}
