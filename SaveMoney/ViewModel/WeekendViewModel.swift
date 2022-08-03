//
//  WeekendViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//
import Foundation

class WeekendViewModel {
    let saveManager = SaveManager.shared
    
    var saveOfDay: [Save] = []
    
    var saves: [Save] {
        return saveManager.saves
    }
    
    var numOfRow: Int {
        return saveOfDay.count
    }
    
    func retrieve() {
        saveManager.retrieveSave()
    }
    
//    func saveOfSelectedDay(date: String) {
//        self.saveOfDay = saveManager.saveOfSelectedDay(date: date)
//    }
}
