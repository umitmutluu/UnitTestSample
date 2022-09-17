//
//  MockDataService_Tests.swift
//  UnitTestSampleTests
//
//  Created by Umut Mutlu on 17.09.2022.
//

import XCTest
@testable import UnitTestSample
import Combine


final class MockDataService_Tests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.removeAll()
    }

    
    func test_mockDataService_init_doesSetValuesCorrectly(){
// Given
        let items : [String]? = nil
        let items2 : [String]? = []
        let items3 : [String]? = [UUID().uuidString,UUID().uuidString,UUID().uuidString]
// When
        let dataService = MockDataService(items: items)
        let dataService2 = MockDataService(items: items2)
        let dataService3 = MockDataService(items: items3)
// Then
        XCTAssertFalse(dataService.items.isEmpty )
        XCTAssertTrue(dataService2.items.isEmpty )
        XCTAssertEqual(dataService3.items.count, items3?.count)
        
    }
    func test_mockDataService_downloadItemsWithEscaping_doesReturnValues (){
// Given
        let dataService = MockDataService(items: nil)
// When
        var items : [String] = []
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithExcaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
// Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
    }
   
    func test_mockDataService_downloadItemsWithCombine_doesReturnValues (){
// Given
        let dataService = MockDataService(items: nil)
// When
        var items : [String] = []
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithCombine().sink { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        } receiveValue: { returnedValue in
            items = returnedValue
            
        }
        .store(in: &cancellables)
// Then
        XCTAssertEqual(items.count, dataService.items.count)
        
    }
    func test_mockDataService_downloadItemsWithCombine_doesFail (){
// Given
        let dataService = MockDataService(items: [] )
// When
        var items : [String] = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw URLError.badServerResponse")
        
        dataService.downloadItemsWithCombine().sink { completion in
            switch completion {
            case .finished:
                XCTFail()
            case .failure(let error):
                expectation.fulfill()
                let urlError = error as? URLError
                XCTAssertEqual(urlError, URLError(.badServerResponse))
                if urlError == URLError(.badServerResponse){
                    expectation2.fulfill()
                }
                }
            
        } receiveValue: { returnedValue in
            items = returnedValue
            
        }
        .store(in: &cancellables)
// Then
        
        XCTAssertEqual(items.count, dataService.items.count)
        
    }
    
    
    
    

}
