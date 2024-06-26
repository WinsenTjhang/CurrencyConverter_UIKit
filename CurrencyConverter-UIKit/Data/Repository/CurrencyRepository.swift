//
//  CurrencyRepository.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 14/06/24.
//

import Foundation

class CurrencyRepository {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getCurrencies() async throws -> [Currency] {
        let data = try await networkService.fetchData(session: .shared)
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategyFormatters = [ DateFormatter.iso8601,
                                                       DateFormatter.lastUpdated,
                                                       DateFormatter.yearMonthDay ]
            
            let result = try decoder.decode(Currencies.self, from: data).list
            return result
        } catch {
            throw DecodeError.decodingFailed
        }
    }
}

enum DecodeError: Error {
    case decodingFailed

    var description: String {
        switch self {
        case .decodingFailed:
            return "Unable to decode data"
        }
    }
}
