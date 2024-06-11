//
//  ConvertViewModel.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

final class ConvertViewModel {
    var conversionType: ConversionType = .toAUD
    var currency: Currency = .sampleCurrency
    
    var currencyCodeForResultView: String {
        ConversionManager.shared.getCurrencyCodeForResultView(currency: currency, selectedType: conversionType)
    }
    
    var currencyCodeForInputView: String {
        ConversionManager.shared.getCurrencyCodeForInputView(currency: currency, selectedType: conversionType)
    }

     func toggleConversionType() {
        switch conversionType {
        case .toAUD:
            conversionType = .fromAUD
        case .fromAUD:
            conversionType = .toAUD
        }
    }
    
    func convertCurrency(amount: String) -> String {
        let result = String(format: "%.2f", ConversionManager.shared.convertCurrency(currency: currency, amount: amount, selectedType: conversionType))
        return result
    }

     func isInvertConversionAvailable() -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.locale = Locale(identifier: "en_US")
        return formatter.number(from: currency.sellTT) != nil
    }
    
}
