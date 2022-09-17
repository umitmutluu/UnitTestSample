//
//  AsyncAwaitSample.swift
//  SwiftUtils
//
//  Created by Umut Mutlu on 13.09.2022.
//

import SwiftUI

class AsyncAwaitDataManager {}

class AsyncAwaitViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    func addFirstOne() {
        let umit = "umit : \(Thread.current)"
        dataArray.append(umit)
    }

    func addAuthor1() async {
        let author1 = "Author1 : \(Thread.current)"
        dataArray.append(author1)

        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let author2 = "Author2 : \(Thread.current)"

        await MainActor.run(body: {
            self.dataArray.append(author2)

            let author3 = "Author 3 : \(Thread.current)"
            self.dataArray.append(author3)
        })
    }

    func somethingAdd() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something = "SomeThing: \(Thread.current)"
        await MainActor.run(body: {
            self.dataArray.append(something)

            let something2 = "something2: \(Thread.current)"
            self.dataArray.append(something2)

        })
    }
}

struct AsyncAwaitSample: View {
    @StateObject private var viewModel = AsyncAwaitViewModel()
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }.onAppear {
            Task {
                await viewModel.addAuthor1()
                await viewModel.somethingAdd()
            }
        }
    }
}

struct AsyncAwaitSample_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitSample()
    }
}
