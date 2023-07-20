//
//  HomePresenter.swift
//  EmulateBankApp
//
//  Created by Владимир Повальский on 24.06.2023.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    var viewController: HomeViewControllerProtocol? { get set }
    var money: Float { get set }
    func presentReplenishmentView()
    func presentWithdrawalView()
    func presentTransferView()
}

final class HomePresenter: HomePresenterProtocol {
    
    var viewController: HomeViewControllerProtocol?
    var money: Float
    
    init(viewController: HomeViewControllerProtocol? = nil) {
        self.viewController = viewController
        if let money = RealmManager.shared.getObjects()?.value {
            self.money = money
        } else {
            RealmManager.shared.createObject()
            if let money = RealmManager.shared.getObjects()?.value {
                self.money = money
            } else {
                self.money = 0
            }
        }
    }
    
    func presentReplenishmentView() {
        let vc = ReplenishmentViewController()
        let presenter: WorkingMoneyPresenterProtocol = ReplenishmentPresenter(viewController: vc)
        presenter.callback = { [weak self] value in
            if let money = self?.money {
                let changedMoney = money + value
                self?.changeMoney(changedMoney)
            }
        }
        vc.presenter = presenter
        viewController?.present(vc, animated: true)
        
    }
    
    func presentWithdrawalView() {
        let vc = WithdrawalViewController()
        let presenter: WorkingMoneyPresenterProtocol = WithdrawalPresenter(viewController: vc)
        presenter.callback = { [weak self] value in
            if let money = self?.money {
                let changedMoney = money - value
                self?.changeMoney(changedMoney)
            }
        }
        vc.presenter = presenter
        viewController?.present(vc, animated: true)
    }
    
    func presentTransferView() {
        let vc = TransferViewController()
        let presenter = TransferPresenter(viewController: vc)
        presenter.callback = { [weak self] value in
            if let money = self?.money {
                let changedMoney = money - value
                self?.changeMoney(changedMoney)
            }
        }
        vc.presenter = presenter
        viewController?.present(vc, animated: true)
    }
    
    private func changeMoney(_ money: Float) {
        RealmManager.shared.updateObjects(money)
        if let money = RealmManager.shared.getObjects()?.value {
            viewController?.replaceMoney(money)
        }
        print("SUCCESS")
    }
    
}
