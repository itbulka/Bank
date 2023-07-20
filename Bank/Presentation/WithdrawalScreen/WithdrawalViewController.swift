//
//  WithdrawalViewController.swift
//  EmulateBankApp
//
//  Created by Владимир Повальский on 24.06.2023.
//

import UIKit

class WithdrawalViewController: WorkingMoneyViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView("Введите сумму для снятие", "Снять")
        
    }

}
