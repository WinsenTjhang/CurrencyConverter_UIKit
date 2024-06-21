//
//  NetworkServiceTests.swift
//  CurrencyConverter-UIKitTests
//
//  Created by winsen on 20/06/24.
//

import XCTest
@testable import CurrencyConverter_UIKit

class NetworkServiceTests: XCTestCase {
    private var networkService: NetworkService!
    private var session: URLSession!
    private var endpoint: URL!

    override func setUp() {
        super.setUp()
        networkService = NetworkService()
        endpoint = URL(string: "https://www.westpac.com.au/bin/getJsonRates.wbc.fx.json")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testFetchData_Success() async throws {
        // Given
        let expectedData = "Test data".data(using: .utf8)!
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.endpoint,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, expectedData)
        }

        // When
        let data = try await networkService.fetchData(session: session)

        // Then
        XCTAssertEqual(data, expectedData)
    }
    
    func testFetchData_Failed() async throws {
        let statusCode = 404
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.endpoint,
                                           statusCode: statusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await networkService.fetchData(session: session)
            XCTFail("Should throw an error")
        } catch {
            guard let networkingError = error as? NetworkError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(networkingError,
                           NetworkError.invalidResponse(statusCode: statusCode),
                           "Error should be a networking error which throws an invalid status code")
            
        }
    }
    
}
