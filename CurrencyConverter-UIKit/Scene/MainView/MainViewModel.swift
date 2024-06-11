//
//  MainViewModel.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

enum DataLoadingStatus {
    case loading
    case loaded([Currency])
    case failed(Error)
}

final class MainViewModel {
    let networkManager: NetworkManager
    var availableCurrencies: [Currency] = []
    var dataLoadingStatus: Observable<DataLoadingStatus> = Observable(.loading)

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
   @MainActor
    func fetchData() {
        dataLoadingStatus.value = .loading
        Task {
            do {
                let data = try await networkManager.getData()
                self.availableCurrencies = data.filter { $0.buyTT != "N/A" }.sorted { $0.currencyCode < $1.currencyCode }
                self.dataLoadingStatus.value = .loaded(self.availableCurrencies)
            } catch {
                self.dataLoadingStatus.value = .failed(error)
            }
        }
    }
    
}
