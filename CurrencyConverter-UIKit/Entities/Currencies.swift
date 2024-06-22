//
//  Currencies.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import Foundation

struct Currencies: Codable {
    var list: [Currency] = []
    
    enum RootKeys: String, CodingKey {
        case apiVersion, status, data
    }
    
    enum DataKeys: String, CodingKey {
        case brands = "Brands"
    }
    
    enum BrandsKeys: String, CodingKey {
        case wbc = "WBC"
    }
    
    enum WBCKeys: String, CodingKey {
        case brand = "Brand", portfolios = "Portfolios"
    }
    
    enum PortfolioKeys: String, CodingKey {
        case fx = "FX"
    }
    
    enum FXKeys: String, CodingKey {
        case portfolioId = "PortfolioId", products = "Products"
    }
    
    enum ProductKeys: String, CodingKey {
        case productId = "ProductId", rates = "Rates"
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        let dataContainer = try container.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        let brandsContainer = try dataContainer.nestedContainer(keyedBy: BrandsKeys.self, forKey: .brands)
        let wbcContainer = try brandsContainer.nestedContainer(keyedBy: WBCKeys.self, forKey: .wbc)
        let portfoliosContainer = try wbcContainer.nestedContainer(keyedBy: PortfolioKeys.self, forKey: .portfolios)
        let fxContainer = try portfoliosContainer.nestedContainer(keyedBy: FXKeys.self, forKey: .fx)
        let productsContainer = try fxContainer.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: .products)
        
        for key in productsContainer.allKeys {
            let productContainer = try productsContainer.nestedContainer(keyedBy: ProductKeys.self, forKey: key)
            let innerProductContainer = try productContainer.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: .rates)
            
            for key in innerProductContainer.allKeys {
                let currency = try innerProductContainer.decode(Currency.self, forKey: key)
                
                list.append(currency)
            }
        }
        
    }
    
}
