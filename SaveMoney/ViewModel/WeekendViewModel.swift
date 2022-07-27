//
//  WeekendViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//
import Foundation

class WeekendViewModel {
    let saveManager = SaveManager.shared
    
    var saves: [Save] {
        return saveManager.saves
    }
    
    var numOfRow: Int {
        return saves.count
    }
    
    func retrieve() {
        saveManager.retrieveSave()
    }
}
