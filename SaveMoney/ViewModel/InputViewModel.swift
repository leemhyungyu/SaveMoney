//
//  InputViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//

import Foundation

class InputViewModel {
    
    let saveManager = SaveManager.shared
    
    var saves: [Save] {
        return saveManager.saves
    }
    
    func addSave(save: Save) {
        saveManager.addSave(save: save)
        saveManager.saveStruct()
    }
}
