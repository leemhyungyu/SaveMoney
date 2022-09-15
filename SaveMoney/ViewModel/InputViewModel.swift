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
    
    var date: Date {
        return saveManager.selectedDate!
    }
    
    var saves: Results<Save> {
        return saveManager.saves!
    }
    
    var eventDay: [Date] {
        return saveManager.eventDay
    }
    
    var selectedSave: Save {
        return saveManager.selectedSave!
    }
    
    var updateSave: Save {
        return saveManager.updateSave!
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
    
    func updateSave(save: Save) {
        saveManager.updateSave(updateSave: save, previousSave: selectedSave)
    }
    
    func updateSelectedSave() {
        saveManager.setSelctedSave(self.updateSave)
    }
    
    func setUpdateSave(planName: String, finalName: String, planMoney: String, finalMoney: String, category: String, check: Bool) -> Save {
        
        let saveMoney = Int(planMoney)! - Int(finalMoney)!
        
        return Save(id: selectedSave.id, day: getStringToDate(date: self.date), planName: planName, planMoney: planMoney, finalName: finalName, finalMoney: finalMoney, saveMoney: String(saveMoney), category: category, check: check)
        
    }
}
