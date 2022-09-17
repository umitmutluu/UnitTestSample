//
//  UnitTestViewModel.swift
//  UnitTestSample
//
//  Created by Umut Mutlu on 17.09.2022.
//

import Foundation
import SwiftUI
import Combine


class UnitTestViewModel : ObservableObject {
    @Published var isPremium : Bool
    @Published var dataArray : [String] = []
    @Published var selectedItem : String? = nil
    var cancelleables = Set<AnyCancellable>()
    let dataService : NewDataServiceProtocol
    
    init(isPremium : Bool, dataService : NewDataServiceProtocol = MockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    func addItem (item :String){
        guard !item.isEmpty else {return}
        self.dataArray.append(item)
    }
    
    func selectItem(item : String){
        if let x = dataArray.first(where: {$0 == item}){
            self.selectedItem = x
        }else {
            self.selectedItem = nil
        }
    }
    
    func saveItem(item :String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        if let x = dataArray.first(where: {$0 == item}){
            print("Save Item here !!! \(x)")
        }else {
            throw DataError.itemNotFound
        }
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping (){
        dataService.downloadItemsWithExcaping {[weak self] returnedItems in
            self?.dataArray = returnedItems
        }
    }
    func downloadWithCombine (){
            dataService.downloadItemsWithCombine()
                .sink {_ in
                    
                } receiveValue: { [weak self] returnedItems in
                    self?.dataArray = returnedItems

                }
                .store(in: &cancelleables)
    }
    
}
