//
//  ConvertViewModelTests.swift
//  CurrencyConverter-UIKitTests
//
//  Created by winsen on 21/06/24.
//

import XCTest
@testable import CurrencyConverter_UIKit

class ConvertViewModelTests: XCTestCase {
    var viewModel: ConvertViewModel!
    var mockCurrencyConverter: CurrencyConverter!
    var mockCurrencyFormatter: CurrencyFormatter!
    var mockCurrencyFormatterUseCase: CurrencyFormatterUseCase!

    override func setUp() {
        super.setUp()
        mockCurrencyConverter = MockCurrencyConverter()
        mockCurrencyFormatter = MockCurrencyFormatter()
        mockCurrencyFormatterUseCase = CurrencyFormatterUseCase(formatter: mockCurrencyFormatter)
        let mockCurrencyConversionUseCase = CurrencyConversionUseCase(converter: mockCurrencyConverter)
        viewModel = ConvertViewModel(currencyConversionUseCase: mockCurrencyConversionUseCase, currencyFormatterUseCase: mockCurrencyFormatterUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockCurrencyConverter = nil
        mockCurrencyFormatterUseCase = nil
        super.tearDown()
    }

    func testConvertCurrency() {
        // Given
        let amount = "100"
        let expectedConversionResult = "200.00" // This should be the expected result of the conversion

        // When
        let conversionResult = viewModel.convertCurrency(amount: amount)

        // Then
        XCTAssertEqual(conversionResult, expectedConversionResult, "The conversion result was not as expected.")
    }
}

class MockCurrencyConverter: CurrencyConverter {
    func convertCurrency(currency: Currency, amount: String, selectedType: ConversionType) -> Double {
        return 200.00
    }
}

class MockCurrencyFormatter: CurrencyFormatter {
    func getCurrencyCodeForResultView(currency: Currency, selectedType: ConversionType) -> String {
        return ""
    }
    
    func getCurrencyCodeForInputView(currency: Currency, selectedType: ConversionType) -> String {
        return ""
    }
    
}
