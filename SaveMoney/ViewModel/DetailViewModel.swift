//
//  DetailViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/09/14.
//

import Foundation

class DetailViewModel {
    
    let saveManager = SaveManager.shared
    
    var saveOfDay: [Save] {
        return saveManager.saveOfDay
    }
    
    var selectedSave: Save {
        return saveManager.selectedSave!
    }
    
    var updateSave: Save {
        return saveManager.updateSave!
    }
    
    var index: Int {
        return saveManager.indexOfSelectedSave!
    }
        
    func saveData() -> Save {
        return saveOfDay[index]
    }
    
    func deleteSave() {
        saveManager.deleteSave(save: saveOfDay[index], index: index)
    }
    
    func setSelctedSave() {
        saveManager.setSelectedSave(save: saveOfDay[index], index: index)
    }
}


