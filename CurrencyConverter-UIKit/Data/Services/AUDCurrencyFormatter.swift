//
//  CurrencyFormatter.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 15/06/24.
//

import Foundation

protocol CurrencyFormatter {
    func getCurrencyCodeForResultView(currency: Currency, selectedType: ConversionType) -> String
    func getCurrencyCodeForInputView(currency: Currency, selectedType: ConversionType) -> String
}

class AUDCurrencyFormatter: CurrencyFormatter {
    func getCurrencyCodeForResultView(currency: Currency, selectedType: ConversionType) -> String {
        switch selectedType {
        case .fromAUD: return "\(currency.currencyCode) \(Locale.locale(from: currency.currencyCode)?.currencySymbol ?? currency.currencyCode) "
        case .toAUD: return "AUD $"
        }
    }
    
    func getCurrencyCodeForInputView(currency: Currency, selectedType: ConversionType) -> String {
        switch selectedType {
        case .toAUD: return "\(currency.currencyCode) \(Locale.locale(from: currency.currencyCode)?.currencySymbol ?? currency.currencyCode) "
        case .fromAUD: return "AUD $"
        }
    }
}
