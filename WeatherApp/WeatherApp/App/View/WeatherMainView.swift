//
//  WeatherMainView.swift
//  WeatherApp
//
//  Created by Umut Mutlu on 14.09.2022.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var langStr: String? = nil
    init() {
        langStr = Locale.current.language.languageCode?.identifier
    }
}

struct WeatherMainView: View {
    @StateObject public var viewmodel = ViewModel()

    var body: some View {
        Text(viewmodel.langStr ?? "nil")
    }
}

struct WeatherMainView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherMainView()
    }
}
