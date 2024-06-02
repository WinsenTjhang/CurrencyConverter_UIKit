//
//  ThemeManager.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 30/05/24.
//

import UIKit

class ThemeManager {
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
        
        var symbol: UIImage? {
            switch self {
            case .light: return UIImage(systemName: "sun.max")
            case .dark: return UIImage(systemName: "moon")
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .light: return UIColor(named: "backgroundLight") ?? .white
            case .dark: return UIColor(named: "backgroundDark") ?? .black
            }
        }
        
        var fxConvertTextColor: UIColor {
            switch self {
            case .light: return .blue
            case .dark: return .white
            }
        }
        
        var font: UIFont {
            switch self {
            case .light: return .systemFont(ofSize: 17)
            case .dark: return UIFont(name: "RobotoCondensed-Regular", size: 20)!
            }
        }
        
        var imageName: String {
            switch self {
            case .light: return "sun"
            case .dark: return "moon"
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


