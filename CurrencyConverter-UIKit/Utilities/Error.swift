//
//  Error.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

enum NetworkError: Error {
    case unableToComplete
    case invalidResponse(statusCode: Int)
    case invalidData
}

