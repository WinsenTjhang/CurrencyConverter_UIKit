//
//  MainViewModel.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation
import Combine

enum DataLoadingStatus {
    case loading
    case loaded([Currency])
    case failed(Error)
}

class MainViewModel {
    let getCurrenciesUseCase: GetCurrenciesUseCase
    var currencies: [Currency] = []
    @Published var dataLoadingStatus: DataLoadingStatus = .loading
    
    var completionHandler: (() -> Void)?
    
    init(getCurrenciesUseCase: GetCurrenciesUseCase) {
        self.getCurrenciesUseCase = getCurrenciesUseCase
    }
    
    @MainActor
    func fetchData() {
        dataLoadingStatus = .loading
        Task {
            defer { completionHandler?() }
            
            do {
                let data = try await getCurrenciesUseCase.execute()
                let filteredData = data.filter { $0.buyTT != "N/A" }.sorted { $0.currencyCode < $1.currencyCode }
                    self.currencies = filteredData
                    self.dataLoadingStatus = .loaded(filteredData)
                
            } catch {
                self.dataLoadingStatus = .failed(error)
            }
        }
    }
    
}
