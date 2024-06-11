//
//  NetworkManager.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

class NetworkManager {
    private let endpoint = "https://www.westpac.com.au/bin/getJsonRates.wbc.fx.json"
    
    func getData() async throws -> [Currency] {
         guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL(URL(string: endpoint))
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        let responseCode = (response as? HTTPURLResponse)?.statusCode
        
        guard responseCode == 200 else {
            throw NetworkError.invalidResponse(statusCode: responseCode!)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategyFormatters = [ DateFormatter.iso8601,
                                                       DateFormatter.lastUpdated,
                                                       DateFormatter.yearMonthDay ]

            return try decoder.decode(Currencies.self, from: data).list
        } catch {
            throw NetworkError.invalidData(originalError: error)
        }
        
    }
    
}
