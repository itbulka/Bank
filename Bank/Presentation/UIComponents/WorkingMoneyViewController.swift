//
//  ReplenishmentViewController.swift
//  EmulateBankApp
//
//  Created by Владимир Повальский on 24.06.2023.
//

import UIKit

protocol WorkingMoneyViewControllerProtocol: AnyObject {
    func getValueFromTextField() -> String?
    func dismissView()
}

protocol WorkingMoneyPresenterProtocol: AnyObject {
    var viewController: WorkingMoneyViewControllerProtocol? { get set }
    var callback: ((Float) -> Void)? { get set }
    func actionAcceptButton()
}

class WorkingMoneyViewController: UIViewController {
    
    var presenter: WorkingMoneyPresenterProtocol?
    
    private var informationLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var iconRubLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.text = "₽"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var enterMoneytextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "10000"
        tf.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        tf.textColor = .systemGreen
        tf.tintColor = .gray
        tf.keyboardType = .numberPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private var dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.transform = .init(scaleX: 1.5, y: 1.5)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var acceptButton: ButtonContinue = ButtonContinue(titleButton: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
        constraintsView()

    }
    
    private func configuration() {
        view.addTapGestureRecognizerToDismissKeyboard() // Сделать как-то глобально
        
        view.backgroundColor = .black
        view.addSubview(informationLabel)
        view.addSubview(iconRubLabel)
        view.addSubview(enterMoneytextField)
        view.addSubview(acceptButton)
        view.addSubview(dismissButton)
        
        dismissButton.addTarget(self, action: #selector(disdismissButtonAction), for: .touchUpInside)
        
    }
    
    func setupView(_ informationTitle: String, _ titleButton: String) {
        informationLabel.text = informationTitle
        acceptButton.setupTitleForButton(titleButton)
        acceptButton.actionButton = { [weak self] in
            self?.presenter?.actionAcceptButton()
        }
    }
    
    private func constraintsView() {
        
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            informationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            informationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            iconRubLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 10),
            iconRubLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconRubLabel.widthAnchor.constraint(equalToConstant: 20),
            
            enterMoneytextField.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 10),
            enterMoneytextField.leadingAnchor.constraint(equalTo: iconRubLabel.trailingAnchor, constant: 8),
            enterMoneytextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            acceptButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            acceptButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            acceptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            acceptButton.heightAnchor.constraint(equalToConstant: 50),
            
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
    }
    
    @objc private func disdismissButtonAction() {
        dismissView()
    }

}

extension WorkingMoneyViewController: WorkingMoneyViewControllerProtocol {
    func dismissView() {
        dismiss(animated: true)
    }
    
    func getValueFromTextField() -> String? {
        return enterMoneytextField.text
    }
    
}
