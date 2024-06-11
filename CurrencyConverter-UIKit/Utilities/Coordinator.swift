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
        guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
        mainViewController.coordinator = self
        mainViewController.viewModel = MainViewModel()
        navigationController.pushViewController(mainViewController, animated: false)
    }

    func navigateToConvertViewController(with currency: Currency) {
        guard let convertViewController = storyboard.instantiateViewController(withIdentifier: "ConvertViewController") as? ConvertViewController else { return }
        convertViewController.coordinator = self
        convertViewController.viewModel = ConvertViewModel()
        convertViewController.viewModel?.currency = currency
        convertViewController.navigationItem.title = "Convert"
       
        navigationController.pushViewController(convertViewController, animated: true)
    }
}
