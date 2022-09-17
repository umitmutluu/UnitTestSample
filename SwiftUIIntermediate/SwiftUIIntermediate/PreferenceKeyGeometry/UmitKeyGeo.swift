//
//  prefkeygeo.swift
//  SwiftUIIntermediate
//
//  Created by Umut Mutlu on 15.09.2022.
//

import SwiftUI

struct UmitKeyGeo: View {
    @State private var rectSize: CGSize = .zero
    var body: some View {
        VStack {
            Text("Hello Buddy")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                GeometryReader { geo in
                    Rectangle()
                        .updateRectangleGeoSize(geo.size)
                }
                Rectangle()
            }.frame(height: 55)
        }.onPreferenceChange(RectanglePreferenceKey.self) { value in
            self.rectSize = value
        }
    }
}

struct UmitKeyGeo_Previews: PreviewProvider {
    static var previews: some View {
        UmitKeyGeo()
    }
}

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectanglePreferenceKey.self, value: size)
    }
}

struct RectanglePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
