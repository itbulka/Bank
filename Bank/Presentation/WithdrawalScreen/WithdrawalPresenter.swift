//
//  WithdrawalPresenter.swift
//  EmulateBankApp
//
//  Created by Владимир Повальский on 24.06.2023.
//

import Foundation

class WithdrawalPresenter: WorkingMoneyPresenterProtocol {
    
    var viewController: WorkingMoneyViewControllerProtocol?
    var callback: ((Float) -> Void)?
    
    init(viewController: WorkingMoneyViewControllerProtocol? = nil) {
        self.viewController = viewController
    }
    
    func actionAcceptButton() {
        guard let valueString = viewController?.getValueFromTextField(), let money = Float(valueString) else { return }
        print("\(money)")
        callback?(money)
        viewController?.dismissView()
    }
    
}
