//
//  TransferViewController.swift
//  EmulateBankApp
//
//  Created by Владимир Повальский on 24.06.2023.
//

import UIKit

protocol TransferViewControllerProtocol: AnyObject {
    func dismissView()
    func getNumberForTextField() -> String?
    func getMoneyFortextField() -> String?
}

class TransferViewController: UIViewController {
    
    var presenter: TransferPresenterProtocol?
    
    private var informationLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "Введите номер телефона на который хотите перевести деньги"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var flagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Icons.flagRussia
        imageView.transform = .init(scaleX: 1.2, y: 1.2)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var phoneTextField: UITextField = {
       let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        tf.tintColor = .gray
        tf.textColor = .white
        tf.placeholder = "+7(123)456-78-90"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private var iconRubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.text = "₽"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var enterMoneyTextField: UITextField = {
       let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        tf.tintColor = .gray
        tf.textColor = .systemGreen
        tf.placeholder = "10000"
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
    
    private var acceptButton: ButtonContinue = ButtonContinue(titleButton: "Снять")

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        constraintsView()
    }
    
    private func configure() {
        view.addTapGestureRecognizerToDismissKeyboard()
        view.backgroundColor = .black
        view.addSubview(informationLabel)
        view.addSubview(flagImage)
        view.addSubview(phoneTextField)
        view.addSubview(iconRubLabel)
        view.addSubview(enterMoneyTextField)
        view.addSubview(acceptButton)
        view.addSubview(dismissButton)
        
        phoneTextField.delegate = self
        
        acceptButton.actionButton = { [weak self] in
            self?.presenter?.transferMoneyForPhone()
        }
        dismissButton.addTarget(self, action: #selector(disdismissButtonAction), for: .touchUpInside)
    }
    
    private func constraintsView() {
        
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            informationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            informationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            flagImage.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
            flagImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            flagImage.widthAnchor.constraint(equalToConstant: 20),
            flagImage.heightAnchor.constraint(equalToConstant: 20),
            
            phoneTextField.centerYAnchor.constraint(equalTo: flagImage.centerYAnchor),
            phoneTextField.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 10),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            iconRubLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            iconRubLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconRubLabel.widthAnchor.constraint(equalToConstant: 20),
            
            enterMoneyTextField.bottomAnchor.constraint(equalTo: iconRubLabel.bottomAnchor),
            enterMoneyTextField.leadingAnchor.constraint(equalTo: iconRubLabel.trailingAnchor, constant: 6),
            enterMoneyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
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

extension TransferViewController: TransferViewControllerProtocol {
    func getNumberForTextField() -> String? {
        return phoneTextField.text
    }
    
    func getMoneyFortextField() -> String? {
        return enterMoneyTextField.text
    }
    
    
    func dismissView() {
        dismiss(animated: true)
    }
    
}

extension TransferViewController: UITextFieldDelegate {
    
    //MARK: проверочный вариант, требуется оптимизация и доп проверки
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        textField.text = formatPhoneNumber(fullString, shouldremoveLastDigit: range.length == 1)
        return false
    }
    
    func formatPhoneNumber(_ phoneNumber: String, shouldremoveLastDigit: Bool) -> String? {
        let maxNumberCount = 11
        let regax = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
        
        guard !(shouldremoveLastDigit && phoneNumber.count <= 2) else { return "+" }
        
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regax.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
        
        if number.count > maxNumberCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldremoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
        }
        
        return "+" + number
    }
    
}
