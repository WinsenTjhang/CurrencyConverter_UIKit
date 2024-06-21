//
//  NetworkService.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 14/06/24.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(session: URLSession) async throws -> Data
}

class NetworkService: NetworkServiceProtocol {
    private let endpoint = "https://www.westpac.com.au/bin/getJsonRates.wbc.fx.json"

    func fetchData(session: URLSession) async throws -> Data {
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL(URL(string: endpoint))
        }

        let (data, response) = try await session.data(from: url)
        let responseCode = (response as? HTTPURLResponse)?.statusCode
        
        guard responseCode == 200 else {
            throw NetworkError.invalidResponse(statusCode: responseCode!)
        }
        
        return data
    }
}

enum NetworkError: Error, Equatable {
    case invalidResponse(statusCode: Int)
    case invalidURL(URL?)

    var description: String {
        switch self {
        case .invalidResponse(let statusCode):
            return "Received invalid response with status code: \(statusCode)"
        case .invalidURL(let url):
            return "Invalid URL: \(url?.absoluteString ?? "nil")"
        }
    }
}
