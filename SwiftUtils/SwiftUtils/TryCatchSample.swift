//
//  TryCatchSample.swift
//  SwiftUtils
//
//  Created by Umut Mutlu on 13.09.2022.
//

import SwiftUI

class TryCatchDataManager {
    let isActive: Bool = true

    func getTitle() -> Result<String, Error> {
        if isActive {
            return .success("New Text")
        } else {
            return .failure(URLError(URLError.badURL))
        }
    }

    func getTitle2() throws -> String {
        if isActive {
            return "New Title"
        } else {
            throw URLError(URLError.badURL)
        }
    }
}

class TryCatchViewModel: ObservableObject {
    @Published var text: String = ""
    let manager = TryCatchDataManager()

    /*
     func fetchTitle (){
            let result = manager.getTitle()

            switch result {
            case .success(let newTitle):
                self.text = newTitle
            case .failure(let error):
                self.text = error.localizedDescription
            }
        }
     */
    func fetchTitle() {
        /*
         let newTitle = try? manager.getTitle2()
         if let newTitleLast = newTitle {
             self.text = newTitleLast
         }
         */

        do {
            let newTitle = try? manager.getTitle2()
            if let newTitleLast = newTitle {
                text = newTitleLast
            }
        } catch {
            text = error.localizedDescription
        }
    }
}

struct TryCatchSample: View {
    @StateObject private var viewModel = TryCatchViewModel()
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(.blue)
            .onAppear {
                viewModel.fetchTitle()
            }
    }
}

struct TryCatchSample_Previews: PreviewProvider {
    static var previews: some View {
        TryCatchSample()
    }
}
