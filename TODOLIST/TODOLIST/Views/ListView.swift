//
//  ListView.swift
//  TODOLIST
//
//  Created by Umut Mutlu on 12.09.2022.
//

import SwiftUI

struct ListView: View {
    @State var items: [String] = [
        "This is first title".capitalized,
        "This is second title".capitalized,
        "this is third title".capitalized,
    ]
    var body: some View {
        List {
            ForEach(items, id: \.self) {
                ListRowView(title: $0)
            }
        }.listStyle(PlainListStyle()).navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add",
                                     destination: Text("deneme destination"))
        )
        .navigationTitle(
            Text("To do List"))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
    }
}
