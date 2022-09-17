//
//  AddView.swift
//  TODOLIST
//
//  Created by Umut Mutlu on 12.09.2022.
//

import SwiftUI

struct AddView: View {
    @State var addTextFieldController = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("Type something here  ...", text: $addTextFieldController).padding(.horizontal).frame(height: 55).background(.gray.opacity(0.5)).cornerRadius(10)

                Button(action: {}, label: { Text("Save"
                        .uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                }).cornerRadius(10)
            }.padding(14)
        }.navigationTitle("sdlkfmşaskfak")
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
