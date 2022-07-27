//
//  SaveManager.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//

import Foundation

class SaveManager {
    
    static let shared = SaveManager()
    
    static var lastId: Int = 0

    private init () { }
    
    var saves: [Save] = []
    
    func createSave(day: String, planName: String, finalName: String, planMoney: String, finalMoney: String) -> Save {
        
        let nextId = SaveManager.lastId + 1
        SaveManager.lastId = nextId
        
        let saveMoney = Int(planMoney)! - Int(finalMoney)!
        
        return Save(id: nextId, day: day, planName: planName, planMoney: planMoney, finalName: finalName, finalMoney: finalMoney, saveMoney: String(saveMoney))
    }
    
    func addSave(save: Save) {
        saves.append(save)
        saveStruct()
    }

    func deleteSave(save: Save) {
        saves = saves.filter { $0.id != save.id}
        saveStruct()
    }
    
    func saveStruct() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(saves), forKey: "Saves")
    }
   
    func retrieveSave() {
        guard let data = UserDefaults.standard.data(forKey: "Saves") else { return }
        saves = (try? PropertyListDecoder().decode([Save].self, from: data))!
    }
}
