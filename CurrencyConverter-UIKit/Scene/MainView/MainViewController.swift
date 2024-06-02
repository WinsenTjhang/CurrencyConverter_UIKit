//
//  ViewController.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 28/05/24.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeSwitcher: UISegmentedControl!
    @IBOutlet weak var currencyTable: UITableView!
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var selectedRowIndex: Int?
    var coordinator: MainCoordinator?
    
    var themeManager: ThemeManager?
    var viewModel: MainViewModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let themeManager = themeManager, let viewModel = viewModel else {
            fatalError("ThemeManager and ViewModel must not be nil")
        }
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        currencyTable.dataSource = self
        currencyTable.delegate = self
        
        let themeSwitcherItem = UIBarButtonItem(customView: themeSwitcher)
        self.navigationItem.rightBarButtonItem = themeSwitcherItem
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13)
        ])
    }
    
    private func setupBindings() {
        viewModel?.dataLoadingStatus.bind { [weak self] status in
            switch status {
            case .loading:
                self?.activityIndicator.startAnimating()
            case .loaded:
                self?.activityIndicator.stopAnimating()
                self?.currencyTable.reloadData()
            case .failed(let error):
                self?.activityIndicator.stopAnimating()
                self?.showError(error)
            }
        }
        viewModel?.fetchData()
    }
    
    @IBAction func switchTheme(_ sender: Any) {
        themeManager?.toggleTheme()
        applyTheme()
    }
    
    func applyTheme() {
        let theme = themeManager?.selectedTheme
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = theme?.scheme ?? .unspecified
        }
        
        view.backgroundColor = theme?.backgroundColor
        currencyTable.reloadData()
    }
    
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currency = viewModel?.availableCurrencies[indexPath.row] else { return }
        coordinator?.navigateToConvertViewController(with: currency)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.availableCurrencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = currencyTable.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        guard let currency = viewModel?.availableCurrencies[indexPath.row] else {return cell}
        
        cell.textLabel?.text = currency.currencyCode + " - " + currency.country + " " + currency.currencyName
        cell.textLabel?.font = themeManager?.selectedTheme.font
        return cell
    }
    
}
