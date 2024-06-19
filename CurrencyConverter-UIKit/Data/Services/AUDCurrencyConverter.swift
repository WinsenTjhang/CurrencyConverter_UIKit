//
//  CurrencyConverter.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 15/06/24.
//

import Foundation

protocol CurrencyConverter {
    func convertCurrency(currency: Currency, amount: String, selectedType: ConversionType) -> Double
}

class AUDCurrencyConverter: CurrencyConverter {
    func convertCurrency(currency: Currency, amount: String, selectedType: ConversionType) -> Double {
        switch selectedType {
        case .toAUD: return ((Double(amount) ?? 0) / (Double(currency.buyTT) ?? 0))
        case .fromAUD: return ((Double(amount) ?? 0) * (Double(currency.sellTT) ?? 0))
        }
    }
}
