//
//  ScrollViewPreferencesKey.swift
//  SwiftUIIntermediate
//
//  Created by Umut Mutlu on 15.09.2022.
//

import SwiftUI

struct ScrollViewPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func onScrollViewOffsetChange(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        background(
            GeometryReader(content: { geo in
                Text("").preference(key: ScrollViewPreferenceKey.self, value: geo.frame(in: .global).minY)
            }))
            .onPreferenceChange(ScrollViewPreferenceKey.self) { value in
                action(value)
            }
    }
}

struct ScrollViewPreferencesKeyBootCamp: View {
    let titleControl: String = "ANANAIN AMCASININ OĞLUNUN KIZININ EVLADININ TORUNUNUN KIZI"
    @State var scrollOffset: CGFloat = .zero
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    titleLayer
                        .opacity(Double(scrollOffset) / 59)
                        .onScrollViewOffsetChange { offset in
                            self.scrollOffset = offset
                        }

                    contentLayer
                }.padding(.horizontal)
            }
            .overlay(Text("\(scrollOffset)"))

            .overlay(navBarLayer.opacity(Double(-scrollOffset) / 59.0), alignment: .top)
        }
    }
}

struct ScrollViewPreferencesKeyBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewPreferencesKeyBootCamp()
    }
}

extension ScrollViewPreferencesKeyBootCamp {
    private var titleLayer: some View {
        Text(titleControl).font(.largeTitle).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading)
    }

    private var contentLayer: some View {
        ForEach(0 ..< 30) { _ in
            RoundedRectangle(cornerRadius: 10).fill(Color.red.opacity(0.3)).frame(width: 300, height: 200)
        }
    }

    private var navBarLayer: some View {
        Text(titleControl)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Material.ultraThin)
    }
}
