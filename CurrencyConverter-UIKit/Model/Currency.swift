//
//  Currency.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

struct Currency: Codable, Hashable {
    let currencyCode: String
    let currencyName: String
    let country: String
    let buyTT: String
    let sellTT: String
    let buyTC: String
    let buyNotes: String
    let sellNotes: String
    let spotRateDate: Date
    let effectiveDate: Date
    let updateDate: Date
    let lastUpdated: Date
    
    private enum CodingKeys: String, CodingKey {
        case currencyCode
        case currencyName
        case country
        case buyTT
        case sellTT
        case buyTC
        case buyNotes
        case sellNotes
        case spotRateDate = "SpotRate_Date_Fmt"
        case effectiveDate = "effectiveDate_Fmt"
        case updateDate = "updateDate_Fmt"
        case lastUpdated = "LASTUPDATED"
    }
    
}

extension Currency {
    static let sampleCurrency: Currency =
    Currency (currencyCode: "IDR", currencyName: "Rupiah", country: "Indo", buyTT: "0.000097", sellTT: "0.5435", buyTC: "N/A", buyNotes: "N/A", sellNotes: "N/A", spotRateDate: Date(), effectiveDate: Date(), updateDate: Date(), lastUpdated: Date())
}
