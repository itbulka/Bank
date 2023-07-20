//
//  Money.swift
//  Bank
//
//  Created by Владимир Повальский on 19.07.2023.
//

import Foundation
import RealmSwift

class Money: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var value: Float = 23400.33
}
