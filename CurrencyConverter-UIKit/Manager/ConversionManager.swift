//
//  ConversionManager.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

enum ConversionType {
    case fromAUD
    case toAUD
}

class ConversionManager {
    static let shared = ConversionManager()
    
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
    
    func convertCurrency(currency: Currency, amount: String, selectedType: ConversionType) -> Double {
        switch selectedType {
        case .toAUD: return ((Double(amount) ?? 0) / (Double(currency.buyTT) ?? 0))
        case .fromAUD: return ((Double(amount) ?? 0) * (Double(currency.sellTT) ?? 0))
        }
        
    }
    
}
