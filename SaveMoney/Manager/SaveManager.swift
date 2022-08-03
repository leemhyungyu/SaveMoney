//
//  SaveManager.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//

import Foundation

class SaveManager {
    
    static let shared = SaveManager()
    
    private init () { }
    
    var saves = [Save]()
    var eventDay = [Date]()
    var saveOfDay = [Save]()
    
    func createSave(day: String, planName: String, finalName: String, planMoney: String, finalMoney: String, category: String) -> Save {
        
        var nextId: Int = 0
        
        if saves.count == 0 {
            nextId = nextId + 1
        } else {
            nextId = saves[saves.index(before: saves.endIndex)].id + 1
        }
        
        let saveMoney = Int(planMoney)! - Int(finalMoney)!
        
        return Save(id: nextId, day: day, planName: planName, planMoney: planMoney, finalName: finalName, finalMoney: finalMoney, saveMoney: String(saveMoney), category: category)
    }
    
    func addSave(save: Save) {
        saves.append(save)
        saveStruct()
    }


    func deleteSave(save: Save, index: Int) {
        saves = saves.filter { $0.id != save.id}
        saveOfDay.remove(at: index)
        eventDay = setEventDay()
        saveStruct()
    }
    
    
    func saveOfSelectedDay(date: String) {
        self.saveOfDay = saves.filter { $0.day == date }
    }
    
    func returnSaveOfSelectedDay(date: String) -> [Save] {
        return saves.filter { $0.day == date }
    }
    
    func saveStruct() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(saves), forKey: "Saves")
        print("saveStruct - called")
    }
   
    func retrieveSave() {
        guard let data = UserDefaults.standard.data(forKey: "Saves") else { return }
        saves = (try? PropertyListDecoder().decode([Save].self, from: data))!
    }
    
    func setEventDay() -> [Date]{
        var result = [String]()
        eventDay = []

        self.saves.map {
            if result.contains($0.day) == false {
                print($0.day)
                result.append($0.day)
            }
        }
        
        for i in result {
            if eventDay.contains(getDateToString(text: i)!) == false {
                self.eventDay.append(getDateToString(text: i)!)
            }
        }
    
        return self.eventDay
    }
    
    func addEventDay(date: String) {
        let date = getDateToString(text: date)
        
        if eventDay.contains(date!) == false {
            eventDay.append(date!)
        }
    }
    
    func addSelectedDay(save: Save) {
        saveOfDay.append(save)
    }
}
