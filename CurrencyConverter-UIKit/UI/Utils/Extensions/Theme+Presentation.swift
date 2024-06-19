//
//  Theme+Presentation.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 15/06/24.
//

import UIKit

extension Theme {
    var scheme: UIUserInterfaceStyle? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }

    var font: UIFont {
        switch self {
        case .light: return .systemFont(ofSize: 17)
        case .dark: return UIFont(name: "RobotoCondensed-Regular", size: 20) ?? .systemFont(ofSize: 20)
        }
    }
}
