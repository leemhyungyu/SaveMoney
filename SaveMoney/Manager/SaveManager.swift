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
    
    var saves = [Save]()
    var eventDay = [Date]()
    
    func createSave(day: String, planName: String, finalName: String, planMoney: String, finalMoney: String, category: String) -> Save {
        
        let nextId = SaveManager.lastId + 1
        SaveManager.lastId = nextId
        
        let saveMoney = Int(planMoney)! - Int(finalMoney)!
        
        return Save(id: nextId, day: day, planName: planName, planMoney: planMoney, finalName: finalName, finalMoney: finalMoney, saveMoney: String(saveMoney), category: category)
    }
    
    func addSave(save: Save) {
        saves.append(save)
        saveStruct()
    }

    func deleteSave(save: Save) {
        saves = saves.filter { $0.id != save.id}
        saveStruct()
    }
    
    func saveOfSelectedDay(date: String) -> [Save] {
        print(saves)
        print(saves.filter { $0.day == date })
        return saves.filter { $0.day == date }
    }
    
    func saveStruct() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(saves), forKey: "Saves")
    }
   
    func retrieveSave() {
        guard let data = UserDefaults.standard.data(forKey: "Saves") else { return }
        saves = (try? PropertyListDecoder().decode([Save].self, from: data))!
    }
    
    func setEventDay() -> [Date]{
        var result = [String]()
        
        self.saves.map {
            if result.contains($0.day) == false {
                result.append($0.day)
            }
        }
        
        for i in result {
            self.eventDay.append(getStringToDate(text: i)!)
        }
        
        return self.eventDay
    }
    
    func addEventDay(date: String) {
        let date = getStringToDate(text: date)
        
        if eventDay.contains(date!) == false {
            eventDay.append(date!)
        }
    }
}
