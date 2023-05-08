//
//  ListRow.swift
//  SampleRealm
//
//  Created by 渡邊魁優 on 2023/04/24.
//

import SwiftUI

struct ListRow: View {
    let task: Task

    var body: some View {
        HStack {
            Text(task.title)
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
