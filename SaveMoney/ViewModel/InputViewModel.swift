//
//  InputViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//

import Foundation
import UIKit

class InputViewModel {
    
    static let shared = InputViewModel()

    let saveManager = SaveManager.shared

    let categories: [Category] = [.food, .transportation, .hobby, .life, .coffee, .etc]

    var date: Date?
    
    var saves: [Save] {
        return saveManager.saves
    }
    
    var eventDay: [Date] {
        return saveManager.eventDay
    }
    
    func addSave(save: Save) {
        saveManager.addSave(save: save)
        saveManager.saveStruct()
        print(saveManager.saves)
    }
    
    func addEventDay(save: Save) {
        saveManager.addEventDay(date: save.day)
    }
    
    func addSelectedDay(save: Save) {
        saveManager.addSelectedDay(save: save)
    }
}
