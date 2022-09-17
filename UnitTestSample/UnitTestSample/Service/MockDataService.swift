//
//  MockDataService.swift
//  UnitTestSample
//
//  Created by Umut Mutlu on 17.09.2022.
//

import Foundation
import SwiftUI
import Combine 

protocol NewDataServiceProtocol {
    func downloadItemsWithExcaping(completion:@escaping (_ items : [String]) -> ())
    func downloadItemsWithCombine() -> AnyPublisher<[String],Error>
}

class MockDataService: NewDataServiceProtocol{
    let items : [String]
    
    init(items: [String]?) {
        self.items = items ?? ["ONE","TWO", "THREE","FOUR"]
    }
    func downloadItemsWithExcaping(completion:@escaping (_ items : [String]) -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            completion(self.items)
        }
    }
    func downloadItemsWithCombine() -> AnyPublisher<[String],Error> {
        Just(items)
            .tryMap ({ publishedItems in
            guard !publishedItems.isEmpty else {
                throw URLError(.badServerResponse)
            }
                return publishedItems
        })
            .eraseToAnyPublisher()
    }
    
    
    
    
}
