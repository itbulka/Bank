//
//  ViewController.swift
//  EmulateBankApp
//
//  Created by Владимир Повальский on 23.06.2023.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func replaceMoney(_ money: Float)
    func present(_ viewController: UIViewController, animated: Bool)
}

class HomeViewController: UIViewController {
    
    var presenter: HomePresenterProtocol?
    
    private var informationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.text = "Ваши сбережения. Вы можете ими распоряжаться как хотите."
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var iconRubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.text = "₽"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var viewBackgroundMenu: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = R.Colors.darkGrayCustom
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private var replenishmentButton: ButtonHomeMenu = .init(image: UIImage(systemName: "rublesign.circle"), titleButton: "Пополнить")
    private var withdrawalButton: ButtonHomeMenu = .init(image: UIImage(systemName: "minus.circle"), titleButton: "Снять")
    private var transferButton: ButtonHomeMenu = .init(image: UIImage(systemName: "candybarphone"), titleButton: "Перевести на мобильную связь")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomePresenter(viewController: self)
        
        configuration()
    }

    private func configuration() {
        view.backgroundColor = .black
        
        view.addSubview(viewBackgroundMenu)
        view.addSubview(informationLabel)
        view.addSubview(iconRubLabel)
        view.addSubview(moneyLabel)
        
        viewBackgroundMenu.addSubview(replenishmentButton)
        viewBackgroundMenu.addSubview(withdrawalButton)
        viewBackgroundMenu.addSubview(transferButton)
        
        constraintsView()
        
        replaceMoney(presenter?.money ?? 0)
        
        replenishmentButton.actionButton = { [weak self] in
            print("Пополнение")
            self?.presenter?.presentReplenishmentView()
        }
        
        withdrawalButton.actionButton = { [weak self] in
           print("Снятие")
            self?.presenter?.presentWithdrawalView()
            
        }
        
        transferButton.actionButton = { [weak self] in
            print("Перевод")
            self?.presenter?.presentTransferView()
        }
        
    }
    
    private func constraintsView() {
        
        NSLayoutConstraint.activate([
            
            viewBackgroundMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewBackgroundMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewBackgroundMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewBackgroundMenu.heightAnchor.constraint(equalToConstant: view.frame.height * 0.7),
            
            informationLabel.bottomAnchor.constraint(equalTo: moneyLabel.topAnchor, constant: -10),
            informationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            informationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            iconRubLabel.bottomAnchor.constraint(equalTo: viewBackgroundMenu.topAnchor, constant: -30),
            iconRubLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconRubLabel.widthAnchor.constraint(equalToConstant: 20),
            
            moneyLabel.bottomAnchor.constraint(equalTo: viewBackgroundMenu.topAnchor, constant: -30),
            moneyLabel.leadingAnchor.constraint(equalTo: iconRubLabel.trailingAnchor, constant: 4),
            moneyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            replenishmentButton.topAnchor.constraint(equalTo: viewBackgroundMenu.topAnchor, constant: 30),
            replenishmentButton.leadingAnchor.constraint(equalTo: viewBackgroundMenu.leadingAnchor, constant: 20),
            replenishmentButton.trailingAnchor.constraint(equalTo: viewBackgroundMenu.trailingAnchor, constant: -20),
            replenishmentButton.heightAnchor.constraint(equalToConstant: 60),
            
            withdrawalButton.topAnchor.constraint(equalTo: replenishmentButton.bottomAnchor, constant: 30),
            withdrawalButton.leadingAnchor.constraint(equalTo: viewBackgroundMenu.leadingAnchor, constant: 20),
            withdrawalButton.trailingAnchor.constraint(equalTo: viewBackgroundMenu.trailingAnchor, constant: -20),
            withdrawalButton.heightAnchor.constraint(equalToConstant: 60),
            
            transferButton.topAnchor.constraint(equalTo: withdrawalButton.bottomAnchor, constant: 30),
            transferButton.leadingAnchor.constraint(equalTo: viewBackgroundMenu.leadingAnchor, constant: 20),
            transferButton.trailingAnchor.constraint(equalTo: viewBackgroundMenu.trailingAnchor, constant: -20),
            transferButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }

}

//MARK: Protocols methods

extension HomeViewController: HomeViewControllerProtocol {
    func present(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated, completion: nil)
    }
    
    func replaceMoney(_ money: Float) {
        moneyLabel.text = "\(money)"
    }
    
    
}
