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

class MainViewModel {
    let getCurrenciesUseCase: GetCurrenciesUseCase
    var currencies: [Currency] = []
    var dataLoadingStatus: Observable<DataLoadingStatus> = Observable(.loading)
    
    var completionHandler: (() -> Void)?

    init(getCurrenciesUseCase: GetCurrenciesUseCase) {
        self.getCurrenciesUseCase = getCurrenciesUseCase
    }
    
   @MainActor
    func fetchData() {
        dataLoadingStatus.value = .loading
        Task {
            defer { completionHandler?() }
            
            do {
                let data = try await getCurrenciesUseCase.execute()
                
                self.currencies = data.filter { $0.buyTT != "N/A" }.sorted { $0.currencyCode < $1.currencyCode }
                self.dataLoadingStatus.value = .loaded(self.currencies)
            } catch {
                self.dataLoadingStatus.value = .failed(error)
            }
        }
    }
    
}
