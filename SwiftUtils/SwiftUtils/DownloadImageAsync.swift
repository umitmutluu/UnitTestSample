//
//  DownloadImageAsync.swift
//  SwiftUtils
//
//  Created by Umut Mutlu on 13.09.2022.
//

import Combine
import SwiftUI

class DownloadImageImageLoader {
    let url = URL(string: "https://picsum.photos/200")

    // MARK: IMAGE UPLOAD SCHEMES

    func handlerResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200, response.statusCode < 300
        else {
            return nil
        }
        return image
    }

    // MARK: IMAGE UPLOAD SCHEMES

    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url!) { data, response, _ in
            let image = self.handlerResponse(data: data, response: response)
            completionHandler(image, nil)
        }.resume()
    }

    // MARK: IMAGE UPLOAD SCHEMES

    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url!)
            .map(handlerResponse)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }

    func downloadWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url!)
            return handlerResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
}

class DownloadImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    var loader = DownloadImageImageLoader()
    var cancelables = Set<AnyCancellable>()
    func fetchImage() async {
        /*
          loader.downloadWithEscaping { [weak self ] image, error in
             DispatchQueue.main.async {
                 self?.image=image
             }
         }
         */
        /* loader.downloadWithCombine()
             .receive(on: DispatchQueue.main)
             .sink { _ in

         } receiveValue: {[weak self ] image in
             self?.image = image
         }.store(in: &cancelables)
         */
        let image = try? await loader.downloadWithAsync()
        await MainActor.run {
            self.image = image
        }
    }
}

struct DownloadImageAsync: View {
    @StateObject private var viewmodel = DownloadImageViewModel()
    var body: some View {
        List {
            ZStack {
                if let image = viewmodel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200).multilineTextAlignment(.center).cornerRadius(10)
                }
            }.onAppear {
                Task {
                    await viewmodel.fetchImage()
                }
            }
            Text("deneme").redacted(reason: RedactionReasons.placeholder)
        }.deleteDisabled(false).listStyle(DefaultListStyle()).overlay(alignment: .center) {}
    }
}

struct DownloadImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageAsync()
    }
}
