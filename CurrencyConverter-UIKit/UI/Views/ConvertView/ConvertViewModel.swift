//
//  ConvertViewModel.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

enum ConversionType {
    case fromAUD
    case toAUD
}

class ConvertViewModel {
    var selectedType: ConversionType = .toAUD
    var currency: Currency = .sampleCurrency
    
    private let currencyConversionUseCase: CurrencyConversionUseCase
    private let currencyFormatterUseCase: CurrencyFormatterUseCase
    
    init(currencyConversionUseCase: CurrencyConversionUseCase,
         currencyFormatterUseCase: CurrencyFormatterUseCase) {
        self.currencyConversionUseCase = currencyConversionUseCase
        self.currencyFormatterUseCase = currencyFormatterUseCase
    }
    
    var currencyCodeForResultView: String {
        currencyFormatterUseCase.getCurrencyCodeForResultView(currency: currency, selectedType: selectedType)
    }
    
    var currencyCodeForInputView: String {
        currencyFormatterUseCase.getCurrencyCodeForInputView(currency: currency, selectedType: selectedType)
    }
    
    func toggleConversionType() {
        switch selectedType {
        case .toAUD:
            selectedType = .fromAUD
        case .fromAUD:
            selectedType = .toAUD
        }
    }
    
    func convertCurrency(amount: String) -> String {
        let result = String(format: "%.2f", currencyConversionUseCase.convertCurrency(currency: currency, amount: amount, selectedType: selectedType))
        return result
    }
    
    func isInvertConversionAvailable() -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.locale = Locale(identifier: "en_US")
        return formatter.number(from: currency.sellTT) != nil
    }
    
    func generateCurrencyDetailText() -> String {
        """
        Currency Name: \(currency.currencyName )
        Country: \(currency.country )
        Buy Rate: \(currency.buyTT )
        Sell Rate: \(currency.sellTT )
        Buy TC: \(currency.buyTC )
        Buy Notes: \(currency.buyNotes )
        Sell Notes: \(currency.sellNotes )
        Spot Rate Date: \(DateFormatter.displayDate.string(from: currency.spotRateDate ))
        Effective Date: \(DateFormatter.displayDate.string(from: currency.effectiveDate ))
        Update Date: \(DateFormatter.displayDate.string(from: currency.updateDate ))
        Last Updated: \(DateFormatter.displayDate.string(from: currency.lastUpdated ))
        """
    }
    
}
