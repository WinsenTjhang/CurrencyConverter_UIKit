//
//  GetCurrenciesUseCase.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 14/06/24.
//

import Foundation

class GetCurrenciesUseCase {
    private let currencyRepository: CurrencyRepository
    
    init(currencyRepository: CurrencyRepository) {
        self.currencyRepository = currencyRepository
    }
    
    func execute() async throws -> [Currency] {
        return try await currencyRepository.getCurrencies()
    }
}
