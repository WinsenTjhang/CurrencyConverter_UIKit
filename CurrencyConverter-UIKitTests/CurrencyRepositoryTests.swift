//
//  CurrencyRepositoryTests.swift
//  CurrencyConverter-UIKitTests
//
//  Created by winsen on 19/06/24.
//

import XCTest
@testable import CurrencyConverter_UIKit

class CurrencyRepositoryTests: XCTestCase {
    var mockNetworkService: MockNetworkService!
    var currencyRepository: CurrencyRepository!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        currencyRepository = CurrencyRepository(networkService: mockNetworkService)
    }

    override func tearDown() {
        mockNetworkService = nil
        currencyRepository = nil
        super.tearDown()
    }

    func testGetCurrencies_Success() async throws {
        // Given
        let staticTestData = try StaticJSONDecoder.decode(file: "FxJsonRates", type: Currencies.self).list
        
        guard let path = Bundle.main.path(forResource: "FxJsonRates", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        
        mockNetworkService.mockData = data

        // When
        let currencies = try await currencyRepository.getCurrencies()

        // Then
        XCTAssertEqual(currencies, staticTestData, "The returned response should be decoded properly")
    }

    func testGetCurrencies_DecodeError() async {
        // Given
        let jsonString = """
        {
            "invalid": "data"
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        mockNetworkService.mockData = jsonData

        // When
        do {
            let _ = try await currencyRepository.getCurrencies()
            XCTFail("Expected getCurrencies to throw DecodeError.decodingFailed")
        } catch {
            // Then
            XCTAssertTrue(error is DecodeError)
            XCTAssertEqual(error as? DecodeError, DecodeError.decodingFailed)
        }
    }
}
