//
//  Error.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

enum NetworkError: Error {
    case unableToComplete(String)
    case invalidResponse(statusCode: Int)
    case invalidData(originalError: Error)
    case invalidURL(URL?)

    var customDescription: String {
        switch self {
        case .unableToComplete(let reason):
            return "Unable to complete network request: \(reason)"
        case .invalidResponse(let statusCode):
            return "Received invalid response with status code: \(statusCode)"
        case .invalidData(let originalError):
            return "Unable to decode data: \(originalError.localizedDescription)"
        case .invalidURL(let url):
            return "Invalid URL: \(url?.absoluteString ?? "nil")"
        }
    }
}

