//
//  CurrencyFormatterUseCase.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 15/06/24.
//

import Foundation

class CurrencyFormatterUseCase {
    private let formatter: CurrencyFormatter

    init(formatter: CurrencyFormatter) {
        self.formatter = formatter
    }

    func getCurrencyCodeForResultView(currency: Currency, selectedType: ConversionType) -> String {
        formatter.getCurrencyCodeForResultView(currency: currency, selectedType: selectedType)
    }
    
    func getCurrencyCodeForInputView(currency: Currency, selectedType: ConversionType) -> String {
        formatter.getCurrencyCodeForInputView(currency: currency, selectedType: selectedType)
    }
    
}
