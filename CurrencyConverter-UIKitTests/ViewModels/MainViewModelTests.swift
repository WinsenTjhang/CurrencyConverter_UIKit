//
//  MainViewModelTests.swift
//  CurrencyConverter-UIKitTests
//
//  Created by winsen on 21/06/24.
//

import XCTest
@testable import CurrencyConverter_UIKit

class MainViewModelTests: XCTestCase {
    var viewModel: MainViewModel!
    var getCurrenciesUseCase: GetCurrenciesUseCase!
    var currencyRepository: CurrencyRepository!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        currencyRepository = CurrencyRepository(networkService: mockNetworkService)
        getCurrenciesUseCase = GetCurrenciesUseCase(currencyRepository: currencyRepository)
        viewModel = MainViewModel(getCurrenciesUseCase: getCurrenciesUseCase)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        currencyRepository = nil
        viewModel = nil
        getCurrenciesUseCase = nil
        super.tearDown()
    }
    
    func testFetchData_Success() async throws {
        // Given
        let expectedCurrencies = try StaticJSONDecoder.decode(file: "FxJsonRates", type: Currencies.self).list.filter { $0.buyTT != "N/A" }.sorted { $0.currencyCode < $1.currencyCode }
        
        guard let path = Bundle.main.path(forResource: "FxJsonRates", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        
        let expectation = XCTestExpectation(description: "Wait for searchFollowers to complete")
        viewModel.completionHandler = {
            expectation.fulfill()
        }
        
        mockNetworkService.mockData = data
        
        // When
        await viewModel.fetchData()
        await fulfillment(of: [expectation], timeout: 1.0)
        
        // Then
        switch viewModel.dataLoadingStatus.value {
        case .loaded(let currencies):
            XCTAssertEqual(currencies, expectedCurrencies)
        default:
            XCTFail("Expected .loaded state, but got \(viewModel.dataLoadingStatus.value)")
        }
    }
    
    func testFetchData_Failed() async throws {
        let expectation = XCTestExpectation(description: "Wait for searchFollowers to complete")
        viewModel.completionHandler = {
            expectation.fulfill()
        }
        
        // When
        await viewModel.fetchData()
        await fulfillment(of: [expectation], timeout: 1.0)
        
        // Then
        switch viewModel.dataLoadingStatus.value {
        case .failed(let error as NetworkError):
            break
        default:
            XCTFail("Expected .failed state, but got \(viewModel.dataLoadingStatus.value)")
        }
        
    }
    
}

