//
//  TransferPresenter.swift
//  EmulateBankApp
//
//  Created by Владимир Повальский on 24.06.2023.
//

import Foundation

protocol TransferPresenterProtocol: AnyObject {
    var viewController: TransferViewControllerProtocol? { get set }
    var callback: ((Float) -> Void)? { get set }
    func transferMoneyForPhone()
}

class TransferPresenter: TransferPresenterProtocol {
    var viewController: TransferViewControllerProtocol?
    var callback: ((Float) -> Void)?
    
    init(viewController: TransferViewControllerProtocol? = nil) {
        self.viewController = viewController
    }
    
    func transferMoneyForPhone() {
        print(#function)
        guard let valueString = viewController?.getMoneyFortextField(),
              let money = Float(valueString) else { return }
        callback?(money)
        viewController?.dismissView()
        guard let phoneNumber = viewController?.getNumberForTextField() else { return }
        print("Вы положили \(money) на \(phoneNumber)")
    }
    
}
