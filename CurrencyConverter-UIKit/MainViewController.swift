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
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        viewModel.delegate = self
        currencyTable.dataSource = self
        currencyTable.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData()

        if viewModel.isFetchingData {
            activityIndicator.startAnimating()
        }
    }
    
}

extension MainViewController: MainViewModelDelegate {
    
    func didFinish() {
        <#code#>
    }
    
    func didFail(_ error: Error) {
        print(error)
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toConvertView", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = currencyTable.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        cell.textLabel?.text = "fwghw"
        
        return cell
    }
    
}

