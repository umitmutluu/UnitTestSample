//
//  CustomNavView.swift
//  SwiftUIIntermediate
//
//  Created by Umut Mutlu on 16.09.2022.
//

import SwiftUI

struct CustomNavView<Content : View >: View {
    let content : Content
    init(@ViewBuilder content : () -> Content ) {
        self.content = content()
    }
    var body: some View {
        NavigationView {
            CustomNavbarContainerView {
content
                
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            Color.red.ignoresSafeArea()
        }
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate=nil
    }
    
}
