//
//  MockNetworkManager.swift
//  CurrencyConverter-UIKitTests
//
//  Created by winsen on 11/06/24.
//

import UIKit
@testable import CurrencyConverter_UIKit

class MockNetworkManager: NetworkManager {
    var data: [Currency]?
    var error: Error?

    override func getData() async throws -> [Currency] {
        if let error = error {
            throw error
        }
        return data ?? []
    }
}
