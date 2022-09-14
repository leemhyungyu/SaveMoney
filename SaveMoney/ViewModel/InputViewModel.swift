//
//  InputViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//

import Foundation
import UIKit
import RealmSwift

class InputViewModel {
    
    static let shared = InputViewModel()

    let saveManager = SaveManager.shared

    let categories: [Category] = [.food, .transportation, .hobby, .life, .coffee, .dress, .study, .save, .etc]

    var checkBoxData: Bool?
    
    var date: Date?
    
    var saves: Results<Save> {
        return saveManager.saves!
    }
    
    var eventDay: [Date] {
        return saveManager.eventDay
    }
    
    func createSave(date: Date, planName: String, finalName: String, planMoney: String, finalMoney: String, category: String, check: Bool) -> Save {
        return saveManager.createSave(day: getStringToDate(date: date), planName: planName, finalName: finalName, planMoney: planMoney, finalMoney: finalMoney, category: category, check: check)
    }
    
    func addSave(save: Save) {
        saveManager.addSave(save: save)
        print(saveManager.saves)
    }
    
    func addEventDay(save: Save) {
        saveManager.addEventDay(date: save.day)
    }
    
    func addSelectedDay(save: Save) {
        saveManager.addSelectedDay(save: save)
    }
}
