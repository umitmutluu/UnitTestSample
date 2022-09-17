//
//  UnitTestViewModel_Tests.swift
//  UnitTestSampleTests
//
//  Created by Umut Mutlu on 17.09.2022.
//

import XCTest
@testable import UnitTestSample
import Combine
final class UnitTestViewModel_Tests: XCTestCase {

    var viewmodel : UnitTestViewModel?
    var cancelable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        viewmodel = UnitTestViewModel(isPremium: Bool.random())

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    viewmodel = nil
    
    }

    func test_UnitTestViewModel_isPremium_shouldBeTrue(){
        
// Given
        let isPremium : Bool = true
// When
        let vm = UnitTestViewModel(isPremium: isPremium)
        
     
// Then
        XCTAssertTrue(vm.isPremium)
        
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeFalse(){
        
// Given
        let isPremium : Bool = false
// When
        let vm = UnitTestViewModel(isPremium: isPremium)
        
     
// Then
        XCTAssertFalse(vm.isPremium)
        
    }
    func test_UnitTestViewModel_isPremium_shouldBeInjectedValue(){
        
// Given
        let isPremium : Bool = Bool.random()
// When
        let vm = UnitTestViewModel(isPremium: isPremium)
        
     
// Then
        XCTAssertEqual(vm.isPremium, isPremium)
        
    }
    func test_UnitTestViewModel_isPremium_shouldBeInjectedValue_stress(){
        
        for _ in 1..<100 {
            // Given
                    let isPremium : Bool = Bool.random()
            // When
                    let vm = UnitTestViewModel(isPremium: isPremium)
                    
                 
            // Then
                    XCTAssertEqual(vm.isPremium, isPremium)
        }
        
    }
    func test_UnitTestViewModel_dataArray_shouldBeEmpty(){
        
// Given
        
// When
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
     
// Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
        
    }
    
    func test_UnitTestViewModel_dataArray_shouldAddItems(){
        
// Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
// When
        
        vm.addItem(item: "hello")
     
// Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 1)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        XCTAssertGreaterThanOrEqual(vm.dataArray.count, 0)
        XCTAssertLessThan(vm.dataArray.count, 2)
        XCTAssertLessThanOrEqual(vm.dataArray.count, 2)
        XCTAssertLessThanOrEqual(vm.dataArray.count, 1)

        
    }
    func test_UnitTestViewModel_dataArray_shouldAddItemsInLoop(){
        
// Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        let loopCount :Int = Int.random(in: 1...100)
// When
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
     
// Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
     }
    func test_UnitTestViewModel_dataArray_shouldNotAddBlankString(){
        
// Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
// When
        
        vm.addItem(item: "")
     
// Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }

    func test_UnitTestViewModel_dataArray_shouldStartAsNil(){
        
// Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
// When
        
        
     
// Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestViewModel_dataArray_shouldBeSelected(){
        
// Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
// When
        let newItem = UUID().uuidString
        vm.addItem(item:newItem)
        vm.selectItem(item: newItem)
        
      
// Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestViewModel_dataArray_shouldBeNilWhenSelectingInvalidItem(){
        
// Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
// When
        let newItem = UUID().uuidString
        vm.addItem(item:newItem)
        vm.selectItem(item: newItem)
        vm.selectItem(item: UUID().uuidString)
        
      
// Then
        XCTAssertNil(vm.selectedItem)
        
    }
    func test_UnitTestViewModel_selectedItem_shouldBeSelected_stress(){
        
// Given

        let vm = UnitTestViewModel(isPremium: Bool.random())
        
// When
        let loopCount :Int = Int.random(in: 0...10)
        var itemsArray: [String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
// Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
        
    }
  
    func test_UnitTestViewModel_savedItem_shouldThrowError_ItemNotFound(){
        
// Given

        let vm = UnitTestViewModel(isPremium: Bool.random())
        
// When
        
// Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString),"Error"){
            error in
            let returnedError = error as? UnitTestViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestViewModel.DataError.itemNotFound)
        }
        
    }
    
    func test_UnitTestViewModel_savedItem_shouldThrowError_noData(){
        
// Given

        let vm = UnitTestViewModel(isPremium: Bool.random())
        
// When
        let loopCount :Int = Int.random(in: 0...100)
        for _ in 0..<loopCount{
            vm.addItem(item: UUID().uuidString)
        }
        
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? UnitTestViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestViewModel.DataError.noData )
        }
        
// Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString),"Error"){
            error in
           
        }
        
    }
    
    
    func test_UnitTestViewModel_savedItem_shouldSaveItem(){
        
        // Given
        
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        let loopCount :Int = Int.random(in: 0...10)
        var itemsArray: [String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
        
        
        
        }

    func test_UnitTestViewModel_sdownloadWithEscaping_shouldReturnItems(){
        
        // Given
        
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        let expectation = XCTestExpectation(description: "Shold Return items after 3 Seconds !!!")
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
            expectation.fulfill()
        }
            .store(in: &cancelable)
        vm.downloadWithEscaping()
    
      
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        
        
        }
    
    func test_UnitTestViewModel_sdownloadWithCombine_shouldReturnItems(){
        
        // Given
        
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        let expectation = XCTestExpectation(description: "Shold Return items after 3 Seconds !!!")
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
            expectation.fulfill()
        }
            .store(in: &cancelable)
        vm.downloadWithCombine()
    
      
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        
        
        }
    
    func test_UnitTestViewModel_sdownloadWithCombine_shouldReturnItems2(){
        
        // Given
        let items = [UUID().uuidString,UUID().uuidString,UUID().uuidString,UUID().uuidString]
        let dataService : NewDataServiceProtocol = MockDataService(items:items)
        let vm = UnitTestViewModel(isPremium: false,dataService: dataService)
        
        // When
        let expectation = XCTestExpectation(description: "Shold Return items after 3 Seconds !!!")
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
            expectation.fulfill()
        }
            .store(in: &cancelable)
        vm.downloadWithCombine()
    
      
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        XCTAssertEqual(vm.dataArray.count, items.count)
        
        
        }
    
    
}
