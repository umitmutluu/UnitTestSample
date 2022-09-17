//
//  CustomNavBarView.swift
//  SwiftUIIntermediate
//
//  Created by Umut Mutlu on 16.09.2022.
//

import SwiftUI

struct CustomNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton : Bool
    let title : String
    let  subtitle : String?
    var body: some View {
        HStack{
            if showBackButton{
                backButton

            }
            Spacer()
            titleSection
            
          
            Spacer()
            if showBackButton{
                backButton.opacity(0)

            }

            
        }
        .padding()
        .accentColor(.white)
        .font(.headline)
        .foregroundColor(.white)
        .background(Color.blue.ignoresSafeArea())
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView(showBackButton: true, title: "title", subtitle: "subbbb")
            Spacer()
        }
    }
}
 

extension CustomNavBarView {
    private var backButton : some View{
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }

    }
    
    private var titleSection : some View{
        VStack(spacing:5){
            Text(title).font(.title).fontWeight(.semibold)
            
            if let subttile = subtitle{
                Text(subttile).font(.subheadline)

            }
        }
    }
    
}
