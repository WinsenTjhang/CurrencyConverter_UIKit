//
//  ThemeManager.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 30/05/24.
//

import UIKit

class ThemeManager {
    static let shared = ThemeManager()
    var selectedTheme: Theme = .light
    
    enum Theme: String, CaseIterable, Identifiable {
        case light
        case dark
        
        var id: String { self.rawValue }
        
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
    
    func toggleTheme() {
        switch selectedTheme {
        case .light:
            selectedTheme = .dark
        case .dark:
            selectedTheme = .light
        }
    }
    
}


