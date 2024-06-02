//
//  ConvertViewModel.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

protocol ConvertViewModelDelegate: AnyObject {
    func didFinish()
    func didFail(_ error: Error)
}

final class ConvertViewModel {
    var conversionType: ConversionType = .toAUD
    var currency: Currency = .sampleCurrency
    weak var delegate: ConvertViewModelDelegate?
    
    func toggleConversionType() {
        switch conversionType {
        case .toAUD:
            conversionType = .fromAUD
        case .fromAUD:
            conversionType = .toAUD
        }
    }
    
    var currencyCodeForResultView: String {
        ConversionManager.shared.getCurrencyCodeForResultView(currency: currency, selectedType: conversionType)
    }
    
    var currencyCodeForInputView: String {
        ConversionManager.shared.getCurrencyCodeForInputView(currency: currency, selectedType: conversionType)
    }
    
    func convertCurrency(amount: String) -> String {
        let result = String(format: "%.2f", ConversionManager.shared.convertCurrency(currency: currency, amount: amount, selectedType: conversionType))
        self.delegate?.didFinish()
        return result
    }

     func isInvertConversionAvailable() -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.locale = Locale(identifier: "en_US")
        return formatter.number(from: currency.sellTT) != nil
    }
    
}
