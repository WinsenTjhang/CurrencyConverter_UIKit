//
//  ViewController.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 28/05/24.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeSwitcher: UISegmentedControl!
    @IBOutlet weak var currencyTable: UITableView!
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var selectedRowIndex: Int?
    var coordinator: MainCoordinator?
    let themeManager = DefaultThemeManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    var viewModel: MainViewModel? {
        didSet {
            viewModel?.fetchData()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard viewModel != nil else {
            fatalError("ThemeManager and ViewModel must not be nil")
        }
        
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
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
    
    func setupBindings() {
        viewModel?.$dataLoadingStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
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
            .store(in: &cancellables)
    }
    
    @IBAction func switchTheme(_ sender: Any) {
        themeManager.toggleTheme()
        applyTheme()
    }
    
    func applyTheme() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = themeManager.selectedTheme.scheme ?? .unspecified
        }
        
        currencyTable.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let lightTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let darkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        if traitCollection.userInterfaceStyle == .dark {
            themeSwitcher.setTitleTextAttributes(darkTextAttributes, for: .normal)
            themeSwitcher.selectedSegmentTintColor = .gray
        } else {
            themeSwitcher.setTitleTextAttributes(lightTextAttributes, for: .normal)
            themeSwitcher.selectedSegmentTintColor = .white
        }
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currency = viewModel?.currencies[indexPath.row] else { return }
        coordinator?.navigateToConvertViewController(with: currency)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.currencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = currencyTable.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        guard let currency = viewModel?.currencies[indexPath.row] else {return cell}
        cell.textLabel?.text = currency.currencyCode + " - " + currency.country + " " + currency.currencyName
        cell.textLabel?.font = DefaultThemeManager.shared.selectedTheme.font
        
        return cell
    }
    
}

