//
//  RealmManager.swift
//  Bank
//
//  Created by Владимир Повальский on 20.07.2023.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    static let shared = RealmManager()
    
    func createObject() {
        let realm = try! Realm()
        let money = Money()
        
        do {
            try realm.write({
                realm.add(money)
            })
        } catch(let error) {
            print(error)
        }
        
    }
    
    func getObjects() -> Money? {
        let realm = try! Realm()
        if let object = realm.objects(Money.self).first {
            return object
        } else {
            return nil
        }
    }
    
    func updateObjects(_ money: Float) {
        let realm = try! Realm()
        if let object = realm.objects(Money.self).first {
            do {
                try realm.write({
                    object.value = money
                })
            } catch(let error) {
                print(error)
            }
        } else {
            print("Error updating data")
        }
    }
    
}
