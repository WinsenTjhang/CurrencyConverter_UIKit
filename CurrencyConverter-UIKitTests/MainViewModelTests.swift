//
//  MainViewModelTests.swift
//  CurrencyConverter-UIKitTests
//
//  Created by winsen on 11/06/24.
//

import XCTest
@testable import CurrencyConverter_UIKit

class MainViewModelTests: XCTestCase {
    var sut: MainViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        sut = MainViewModel(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        sut = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testFetchDataSuccess() async throws {
        let currency = Currency.sampleCurrency
        mockNetworkManager.data = [Currency.sampleCurrency]

        let expectation = XCTestExpectation(description: "Wait for fetchData to complete")
        sut.completionHandler = {
            expectation.fulfill()
        }
        
        await sut.fetchData()
        await fulfillment(of: [expectation], timeout: 1.0)
        
        guard case .loaded(let _) = sut.dataLoadingStatus.value else {
            XCTFail("Expected .loaded state")
            return
        }
        
        XCTAssertEqual(sut.availableCurrencies, [currency])
    }

    func testFetchDataFailure() async throws {
        let error = NSError(domain: "test", code: 1, userInfo: nil)
        mockNetworkManager.error = error

        let expectation = XCTestExpectation(description: "Wait for fetchData to complete")
        sut.completionHandler = {
            expectation.fulfill()
        }
        
        await sut.fetchData()
        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .failed(let actualError) = sut.dataLoadingStatus.value else {
            XCTFail("Expected .failed state")
            return
        }
        
        XCTAssertEqual(actualError as NSError, error)
    }
}


