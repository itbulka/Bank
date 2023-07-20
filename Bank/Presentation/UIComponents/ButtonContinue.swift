//
//  ButtonContinue.swift
//  EmulateBankApp
//
//  Created by Владимир Повальский on 24.06.2023.
//

import UIKit

class ButtonContinue: UIButton {

    var actionButton: (() -> Void?)? = nil
    
    private var nameButtonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(titleButton: String) {
        super.init(frame: .zero)
        nameButtonLabel.text = titleButton
        
        setupButton()
        constraintsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleForButton(_ title: String) {
        nameButtonLabel.text = title
    }
    
    private func setupButton() {
        backgroundColor = .yellow
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameButtonLabel)
        
        addTarget(self, action: #selector(animationButtonAction), for: .touchUpInside)
    }
    
    @objc private func animationButtonAction() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self?.actionButton?()
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                self?.transform = .identity
            })
        })
    }
    
    private func constraintsView() {
        
        NSLayoutConstraint.activate([
            
            nameButtonLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameButtonLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
        
    }

}
