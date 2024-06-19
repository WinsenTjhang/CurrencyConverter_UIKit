//
//  CurrencyConversionUseCase.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 15/06/24.
//

import Foundation

class CurrencyConversionUseCase {
    private let converter: CurrencyConverter

    init(converter: CurrencyConverter) {
        self.converter = converter
    }

    func convertCurrency(currency: Currency, amount: String, selectedType: ConversionType) -> Double {
        let convertedAmount = converter.convertCurrency(currency: currency, amount: amount, selectedType: selectedType)
        return convertedAmount
    }
    
}
