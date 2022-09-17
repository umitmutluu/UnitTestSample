//
//  UnitTestView.swift
//  UnitTestSample
//
//  Created by Umut Mutlu on 17.09.2022.
//

import SwiftUI



struct UnitTestView: View {
    @StateObject private var vm :UnitTestViewModel
    
    init(isPremium:Bool) {
        _vm = StateObject(wrappedValue: UnitTestViewModel(isPremium: isPremium))
         
        
    }
    var body: some View {
        Text(vm.isPremium.description )
    }
}

struct UnitTestView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestView(isPremium:  true)
    }
}
