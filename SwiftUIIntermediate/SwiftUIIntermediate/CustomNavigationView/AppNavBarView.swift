//
//  AppNavBarView.swift
//  SwiftUIIntermediate
//
//  Created by Umut Mutlu on 15.09.2022.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack{
                Color.orange.ignoresSafeArea()
                    CustomNavLink(destination: Text("Custom DESTİNATİON")
                        .customNavigationTitle("new Custom Title")
                        .customNavigationSubTitle("new Custom subtitle")
                        .customNavigationBackButtonHidden(false))
                    {
                        Text("CUSTOM LABEL")
                    }
                   
                
            }
            .customNavBarItems("TİTLE","SUBTİTLE",true)
        }
    }
}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}


extension AppNavBarView {
    private var defaultNavView : some View {
        NavigationView {
            
            ZStack{
                Color.green.ignoresSafeArea()

                NavigationLink(
                    destination:
                        Text("Navigate Screen")
                        .navigationTitle("title 2 ")
                        .navigationBarBackButtonHidden(false),
                    label: { Text("Navigate") }
                )
            }
            .navigationTitle("AppNavBarTitle")

                                        
        }
    }
}
