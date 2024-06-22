//
//  LocaleExtensions.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

extension Locale {
    static func locale(from currencyIdentifier: String) -> Locale? {
        let allLocales = Locale.availableIdentifiers.map({ Locale.init(identifier: $0) })
        return allLocales.first(where: { $0.currencyCode == currencyIdentifier })
    }
}
