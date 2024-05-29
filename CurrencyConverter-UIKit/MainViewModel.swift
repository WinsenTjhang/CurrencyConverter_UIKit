//
//  MainViewModel.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func didFinish()
    func didFail(_ error: Error)
}

final class MainViewModel {
    let networkManager = NetworkManager()
    var isFetchingData = true
    var currencies: [Currency] = []
    
    weak var delegate: MainViewModelDelegate?
    
    func fetchData() {
        Task {
            do {
                let data = try await networkManager.getData()
                self.currencies = data.list.sorted { $0.currencyCode < $1.currencyCode }
                isFetchingData = false
            } catch {
                print(error)
            }
        }
        
        
    }
    
}
