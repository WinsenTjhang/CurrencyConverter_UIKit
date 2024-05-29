//
//  NetworkManager.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

final class NetworkManager {
    private let endpoint = "https://www.westpac.com.au/bin/getJsonRates.wbc.fx.json"
    
    func getData() async throws -> Currencies {
        let url = URL(string: endpoint)
        let (data, response) = try await URLSession.shared.data(from: url!)
        let responseCode = (response as? HTTPURLResponse)?.statusCode
        
        guard responseCode == 200 else {
            throw NetworkError.invalidResponse(statusCode: responseCode!)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategyFormatters = [ DateFormatter.iso8601,
                                                       DateFormatter.lastUpdated,
                                                       DateFormatter.yearMonthDay ]

            return try decoder.decode(Currencies.self, from: data)
        } catch {
            print("\(error)\n")
            throw NetworkError.invalidData
        }
        
    }
    
}
