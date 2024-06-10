//
//  ConvertViewController.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 29/05/24.
//

import UIKit

class ConvertViewController: UIViewController {
    
    @IBOutlet weak var fxCodeLabel: UILabel!
    @IBOutlet weak var currencyResultCode: UILabel!
    @IBOutlet weak var currencyInputCode: UILabel!
    @IBOutlet weak var resultAmount: UILabel!
    @IBOutlet weak var inputAmount: UITextField!
    
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    
    var viewModel: ConvertViewModel?
    var coordinator: MainCoordinator?
    let inputViewRectangle = UIView()
    let currencyDetailsRectangle = UIView()
    let divider = UIView()
    let currencyDetail = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputAmount.delegate = self
        
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        setupInputView()
        setupCurrencyDetail()
        
        setupViewWithShadow(resultView)
        setupViewWithShadow(swapButton)
        
        setupViewWithShadow(currencyDetailsRectangle)
    }
    
    private func bindViewModel() {
        fxCodeLabel.text = viewModel?.currency.currencyCode
        currencyResultCode.text = viewModel?.currencyCodeForResultView
        currencyInputCode.text = viewModel?.currencyCodeForInputView
    }
    
    func setupViewWithShadow(_ view: UIView) {
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 8
    }
    
    @IBAction func swapButton(_ sender: UIButton) {
        viewModel?.toggleConversionType()
        updateCurrencyCodes()
        resultAmount.text = "0.00"
        inputAmount.text = ""
    }
    
    func updateCurrencyCodes() {
        currencyResultCode.text = viewModel?.currencyCodeForResultView
        currencyInputCode.text = viewModel?.currencyCodeForInputView
        swapButton.isEnabled = viewModel?.isInvertConversionAvailable() ?? false
    }
    
    @objc func inputDoneButtonTapped() {
        view.endEditing(true)
    }
    
}

extension ConvertViewController {
    func setupInputView() {
        view.addSubview(inputViewRectangle)
        
        setupDivider()
        setupCurrencyInputCode()
        setupInputAmount()
        setupInputViewRectangle()
        
        setupConstraints()
    
        setupToolbarForInputAmount()
    }
    
    private func setupInputViewRectangle() {
        inputViewRectangle.backgroundColor = .white
        inputViewRectangle.layer.cornerRadius = 10
        inputViewRectangle.translatesAutoresizingMaskIntoConstraints = false
        setupViewWithShadow(inputViewRectangle)
    }
    
    private func setupDivider() {
        divider.backgroundColor = .lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        inputViewRectangle.addSubview(divider)
    }
    
    private func setupCurrencyInputCode() {
        currencyInputCode.translatesAutoresizingMaskIntoConstraints = false
        inputViewRectangle.addSubview(currencyInputCode)
    }
    
    private func setupInputAmount() {
        inputAmount.translatesAutoresizingMaskIntoConstraints = false
        inputViewRectangle.addSubview(inputAmount)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            inputViewRectangle.widthAnchor.constraint(equalToConstant: 300),
            inputViewRectangle.heightAnchor.constraint(equalToConstant: 50),
            inputViewRectangle.topAnchor.constraint(equalTo: swapButton.bottomAnchor, constant: 60),
            inputViewRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputViewRectangle.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 10),
            inputViewRectangle.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),
            
            divider.leadingAnchor.constraint(equalTo: currencyInputCode.trailingAnchor, constant: 5),
            divider.centerYAnchor.constraint(equalTo: inputViewRectangle.centerYAnchor),
            divider.heightAnchor.constraint(equalTo: inputViewRectangle.heightAnchor, multiplier: 0.6),
            divider.widthAnchor.constraint(equalToConstant: 1),
            
            currencyInputCode.topAnchor.constraint(equalTo: inputViewRectangle.topAnchor, constant: 10),
            currencyInputCode.leadingAnchor.constraint(equalTo: inputViewRectangle.leadingAnchor, constant: 10),
            currencyInputCode.bottomAnchor.constraint(equalTo: inputViewRectangle.bottomAnchor, constant: -10),
            
            inputAmount.topAnchor.constraint(equalTo: inputViewRectangle.topAnchor, constant: 10),
            inputAmount.leadingAnchor.constraint(equalTo: divider.trailingAnchor, constant: 15),
            inputAmount.trailingAnchor.constraint(equalTo: inputViewRectangle.trailingAnchor, constant: -10),
            inputAmount.bottomAnchor.constraint(equalTo: inputViewRectangle.bottomAnchor, constant: -10),
        ])
        
    }
    
    private func setupToolbarForInputAmount() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let inputDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(inputDoneButtonTapped))
        toolbar.setItems([inputDoneButton], animated: false)
        inputAmount.inputAccessoryView = toolbar
    }
    
}

extension ConvertViewController {
    func setupCurrencyDetail() {
        view.addSubview(currencyDetailsRectangle)
        
        currencyDetail.numberOfLines = 0
        currencyDetail.font = UIFont.systemFont(ofSize: 14)
        currencyDetail.text =
        "Currency Name: \(viewModel?.currency.currencyName ?? "N/A")\n" +
        "Country: \(viewModel?.currency.country ?? "N/A")\n" +
        "Buy Rate: \(viewModel?.currency.buyTT ?? "N/A")\n" +
        "Sell Rate: \(viewModel?.currency.sellTT ?? "N/A")\n" +
        "Buy TC: \(viewModel?.currency.buyTC ?? "N/A")\n" +
        "Buy Notes: \(viewModel?.currency.buyNotes ?? "N/A")\n" +
        "Sell Notes: \(viewModel?.currency.sellNotes ?? "N/A")\n" +
        "Spot Rate Date: \(DateFormatter.displayDate.string(from: viewModel?.currency.spotRateDate ?? Date()))\n" +
        "Effective Date: \(DateFormatter.displayDate.string(from: viewModel?.currency.effectiveDate ?? Date()))\n" +
        "Update Date: \(DateFormatter.displayDate.string(from: viewModel?.currency.updateDate ?? Date()))\n" +
        "Last Updated: \(DateFormatter.displayDate.string(from: viewModel?.currency.lastUpdated ?? Date()))"
        
        currencyDetailsRectangle.backgroundColor = .white
        currencyDetailsRectangle.layer.cornerRadius = 10
        currencyDetailsRectangle.addSubview(currencyDetail)
        
        
        currencyDetailsRectangle.translatesAutoresizingMaskIntoConstraints = false
        currencyDetail.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            currencyDetailsRectangle.widthAnchor.constraint(equalToConstant: 300),
            currencyDetailsRectangle.topAnchor.constraint(equalTo: inputViewRectangle.bottomAnchor, constant: 35),
            currencyDetailsRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currencyDetailsRectangle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            currencyDetailsRectangle.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 10),
            currencyDetailsRectangle.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            currencyDetail.topAnchor.constraint(equalTo: currencyDetailsRectangle.topAnchor, constant: 15),
            currencyDetail.leadingAnchor.constraint(equalTo: currencyDetailsRectangle.leadingAnchor, constant: 15),
            currencyDetail.bottomAnchor.constraint(equalTo: currencyDetailsRectangle.bottomAnchor, constant: -15),
            currencyDetail.trailingAnchor.constraint(equalTo: currencyDetailsRectangle.trailingAnchor, constant: -15),
        ])
    }
}

// Direct conversion of currency after each keyboard input
extension ConvertViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == inputAmount {
            let currentAmount = textField.text ?? ""
            let newAmount = (currentAmount as NSString).replacingCharacters(in: range, with: string)
            resultAmount.text = viewModel?.convertCurrency(amount: newAmount)
        }
        
        return true
    }
    
}
