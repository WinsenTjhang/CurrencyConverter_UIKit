//
//  File.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 15/06/24.
//

import Foundation

protocol ThemeManager {
    var selectedTheme: Theme { get set }
    func toggleTheme()
}

enum Theme: String, CaseIterable, Identifiable {
    case light
    case dark
    var id: String { self.rawValue }
}

class DefaultThemeManager: ThemeManager {
    static let shared = DefaultThemeManager()
    var selectedTheme: Theme = .light

    func toggleTheme() {
        switch selectedTheme {
        case .light:
            selectedTheme = .dark
        case .dark:
            selectedTheme = .light
        }
    }
}
