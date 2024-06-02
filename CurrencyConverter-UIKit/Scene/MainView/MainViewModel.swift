//
//  MainViewModel.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

enum DataLoadingStatus {
    case loading
    case loaded
    case failed(Error)
}

final class MainViewModel {
    let networkManager = NetworkManager()
    var availableCurrencies: [Currency] = []
    var dataLoadingStatus: Observable<DataLoadingStatus> = Observable(.loading)
    
   @MainActor
    func fetchData() {
        dataLoadingStatus.value = .loading
        Task {
            do {
                let data = try await networkManager.getData()
                self.availableCurrencies = data.list.filter { $0.buyTT != "N/A" }.sorted { $0.currencyCode < $1.currencyCode }
                self.dataLoadingStatus.value = .loaded
            } catch {
                self.dataLoadingStatus.value = .failed(error)
            }
        }
    }
    
}
