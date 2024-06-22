//
//  NetworkServiceMock.swift
//  CurrencyConverter-UIKitTests
//
//  Created by winsen on 19/06/24.
//

import Foundation
@testable import CurrencyConverter_UIKit

class MockNetworkService: NetworkServiceProtocol {
    var mockData: Data?
    
    func fetchData(session: URLSession) async throws -> Data {
        if let data = mockData {
            return data
        } else {
            throw NetworkError.invalidResponse(statusCode: 404)
        }
    }
}
