//
//  CustomNavbarContainerView.swift
//  SwiftUIIntermediate
//
//  Created by Umut Mutlu on 16.09.2022.
//

import SwiftUI

struct CustomNavbarContainerView< Content: View >: View {
    let content : Content
    @State private var showBackButton : Bool = true
    @State private var title : String = "Title"
    @State private var subtitle : String? = "Subtitle"
    
    
    init(@ViewBuilder content :() -> Content) {
        self.content = content()
    }
    
    
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
            content.frame(maxWidth: .infinity,maxHeight: .infinity)
        }.onPreferenceChange(CustomNavBarTitlePrefKey.self) { value in
            self.title = value
        }.onPreferenceChange(CustomNavBarSubTitlePrefKey.self) { value in
            self.subtitle = value
        }.onPreferenceChange(CustomNavBarBackButtonPrefKey.self) { value in
            self.showBackButton = !value
        }
    }
}

struct CustomNavbarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavbarContainerView {
            ZStack{
                Color.green.ignoresSafeArea()
                Text("Hello Guys!").foregroundColor(.white)
                
            }
            .customNavigationTitle("neew title")
            .customNavigationSubTitle("new sub title")
            .customNavigationBackButtonHidden(true)
        }
    }
}
