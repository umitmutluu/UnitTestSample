//
//  CustomNavBarPrefKey.swift
//  SwiftUIIntermediate
//
//  Created by Umut Mutlu on 16.09.2022.
//

import Foundation
import SwiftUI
//@Environment(\.presentationMode) var presentationMode
//@State private var showBackButton : Bool = true
//@State private var title : String = "Title"
//@State private var subtitle : String? = "Subtitle"
 

struct CustomNavBarTitlePrefKey : PreferenceKey {
    static var defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
struct CustomNavBarSubTitlePrefKey : PreferenceKey {
    static var defaultValue: String? = nil
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    
    }
}

struct CustomNavBarBackButtonPrefKey : PreferenceKey {
    static var defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
//    .navigationTitle("title 2 ")
//    .navigationBarBackButtonHidden(false)
    func customNavigationTitle (_ title: String ) -> some  View {
        preference(key: CustomNavBarTitlePrefKey.self,value: title)}
    
    func customNavigationSubTitle(_ subtitle: String? ) -> some  View {
        preference(key: CustomNavBarSubTitlePrefKey.self,value: subtitle)}
    
    func customNavigationBackButtonHidden (_ isHidden: Bool ) -> some  View {
        preference(key: CustomNavBarBackButtonPrefKey.self,value: isHidden)}
    
    func customNavBarItems (_ title:String = "",_ subTitle:String? = nil ,_ isHidden:Bool = false ) -> some View {
        self
            .customNavigationTitle(title)
            .customNavigationSubTitle(subTitle)
            .customNavigationBackButtonHidden(isHidden)
    
    }
    
    
}
