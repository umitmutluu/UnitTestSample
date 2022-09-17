//
//  ListRowView.swift
//  TODOLIST
//
//  Created by Umut Mutlu on 12.09.2022.
//

import SwiftUI

struct ListRowView: View {
    let title: String
    var body: some View {
        HStack {
            Image(systemName: "person.wave.2")
            Text("First Item")
            Spacer()
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(title: "Test title")
    }
}
