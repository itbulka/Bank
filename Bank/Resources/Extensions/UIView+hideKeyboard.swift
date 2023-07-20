//
//  UIView+hideKeyboard.swift
//  EmulateBankApp
//
//  Created by Владимир Повальский on 24.06.2023.
//

import UIKit

extension UIView {
    func addTapGestureRecognizerToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}
