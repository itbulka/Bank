//
//  ButtonHomeMenu.swift
//  EmulateBankApp
//
//  Created by Владимир Повальский on 23.06.2023.
//

import UIKit

class ButtonHomeMenu: UIButton {
    
    var actionButton: (() -> Void?)? = nil
    
    private var imageButton: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameButtonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(image: UIImage?, titleButton: String) {
        super.init(frame: .zero)
        imageButton.image = image
        nameButtonLabel.text = titleButton
        
        setupButton()
        constraintsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        backgroundColor = .darkGray
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageButton)
        addSubview(nameButtonLabel)
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
    }
    
    @objc private func buttonTapped() {
        actionButton?()
    }
    
    @objc private func buttonTouchDown() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    @objc private func buttonTouchUp() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    private func constraintsView() {
        
        NSLayoutConstraint.activate([
        
            imageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageButton.widthAnchor.constraint(equalToConstant: 30),
            imageButton.heightAnchor.constraint(equalToConstant: 30),
            imageButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameButtonLabel.leadingAnchor.constraint(equalTo: imageButton.trailingAnchor, constant: 10),
            nameButtonLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameButtonLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
        
    }
    
}
