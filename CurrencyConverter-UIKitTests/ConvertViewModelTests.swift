//
//  ConvertViewModelTests.swift
//  CurrencyConverter-UIKitTests
//
//  Created by winsen on 12/06/24.
//

import Foundation
import XCTest
@testable import CurrencyConverter_UIKit

class ConvertViewModelTests: XCTestCase {
    
    var viewModel: ConvertViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ConvertViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testToggleConversionType() {
        let initialConversionType = viewModel.conversionType
        viewModel.toggleConversionType()
        
        XCTAssertNotEqual(viewModel.conversionType, initialConversionType)
    }
    
    func testConvertCurrency() {
        let amount = "100"
        let result = viewModel.convertCurrency(amount: amount)
        
        XCTAssertEqual(result, "105.91")
    }
    
    func testIsInvertConversionAvailable() {
        let isInvertConversionAvailable = viewModel.isInvertConversionAvailable()
        
        XCTAssertTrue(isInvertConversionAvailable)
    }
    
    
}
