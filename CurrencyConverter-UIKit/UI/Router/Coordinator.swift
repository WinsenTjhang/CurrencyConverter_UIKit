//
//  Coordinator.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 03/06/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator : Coordinator {
    var navigationController: UINavigationController
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkService = NetworkService()
        let currencyRepository = CurrencyRepository(networkService: networkService)
        let getCurrenciesUseCase = GetCurrenciesUseCase(currencyRepository: currencyRepository)
        guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
        mainViewController.coordinator = self
        mainViewController.viewModel = MainViewModel(getCurrenciesUseCase: getCurrenciesUseCase)
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
    func navigateToConvertViewController(with currency: Currency) {
        let currencyConverter = AUDCurrencyConverter()
        let currencyFormatter = AUDCurrencyFormatter()
        let currencyConversionUseCase = CurrencyConversionUseCase(converter: currencyConverter)
        let currencyFormatterUseCase = CurrencyFormatterUseCase(formatter: currencyFormatter)
        
        guard let convertViewController = storyboard.instantiateViewController(withIdentifier: "ConvertViewController") as? ConvertViewController else { return }
        convertViewController.coordinator = self
        convertViewController.viewModel = ConvertViewModel(currencyConversionUseCase: currencyConversionUseCase, currencyFormatterUseCase: currencyFormatterUseCase)
        convertViewController.viewModel?.currency = currency
        convertViewController.navigationItem.title = "Convert"
        
        navigationController.pushViewController(convertViewController, animated: true)
    }
}
