//
//  CustomNavLink.swift
//  SwiftUIIntermediate
//
//  Created by Umut Mutlu on 16.09.2022.
//

import SwiftUI

struct CustomNavLink< Label : View,Destination : View  >: View {
    let destination: Destination
    let label : Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label){
        self.destination = destination
        self.label = label()
    }
    var body: some View {
        NavigationLink(destination:
                        CustomNavbarContainerView(content: {
            destination.navigationBarHidden(true)
        }
)
        ) {
            label
        }
    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
        
        CustomNavView{
            CustomNavLink(destination: Text("DESTİNATİON"),label: {Text("LABELLL")})
        }
        
    }
}
