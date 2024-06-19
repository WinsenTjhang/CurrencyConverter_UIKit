//
//  Observable.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 02/06/24.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    private var observer: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ observer: @escaping (T) -> Void) {
        self.observer = observer
        observer(value)
    }
}
