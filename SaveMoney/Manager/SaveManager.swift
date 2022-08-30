//
//  SaveManager.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//

import Foundation
import RealmSwift

class SaveManager {
    
    static let shared = SaveManager()
    
    private init () { }
    
    let realm = try! Realm()
    
    var saves: Results<Save>?
//    var saves = [Save]()
    var eventDay = [Date]()
    var saveOfDay = [Save]()
    var totalMoney: Int = 0
    var monthMoney: [Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var eachDayAndMoney = [String: Double]()
    var EachWeekendDayAndMoney = [String: Double]()
    
    func createSave(day: String, planName: String, finalName: String, planMoney: String, finalMoney: String, category: String) -> Save {
        
        var nextId: Int = 0
        
        if saves!.count == 0 {
            nextId = nextId + 1
        } else {
            nextId = saves![saves!.index(before: saves!.endIndex)].id + 1
        }
        
        let saveMoney = Int(planMoney)! - Int(finalMoney)!
        
        return Save(id: nextId, day: day, planName: planName, planMoney: planMoney, finalName: finalName, finalMoney: finalMoney, saveMoney: String(saveMoney), category: category)
    }
    
    func addSave(save: Save) {
//        saves.append(save)
        
        try! realm.write {
            realm.add(save)
        }
        
        totalMoney += Int(save.saveMoney)!
        setMonthMoneyData(save: save)
        UserDefaults.standard.set(totalMoney, forKey: "totalMoney")
    }


    func deleteSave(save: Save, index: Int) {
                
        totalMoney -= Int(saveOfDay[index].saveMoney)!
        saveOfDay.remove(at: index)
        deleteMonthMoneyData(save: save)

        UserDefaults.standard.set(totalMoney, forKey: "totalMoney")
        
        let selectData = realm.objects(Save.self).filter(NSPredicate(format: "id == %d", save.id)).first
        
        do {
            try realm.write {
                realm.delete(selectData!)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        eventDay = setEventDay()
    }
    
    
    func saveOfSelectedDay(date: String) {
        self.saveOfDay = saves!.filter { $0.day == date }
    }
    
    func returnSaveOfSelectedDay(date: String) -> [Save] {
        return saves!.filter { $0.day == date }
    }
    
    
    func saveStruct() {
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(saves), forKey: "Saves")
//        UserDefaults.standard.set(totalMoney, forKey: "totalMoney")
    }
   
    func retrieveSave() {
//        guard let data = UserDefaults.standard.data(forKey: "Saves") else { return }
//        saves = (try? PropertyListDecoder().decode([Save].self, from: data))!
        
        do {
            try realm.write {
                self.saves = realm.objects(Save.self)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        totalMoney = UserDefaults.standard.integer(forKey: "totalMoney")
    }
    
    func setEventDay() -> [Date]{

        var result = [String]()
        eventDay = []

        if saves!.count >= 1 {
            for i in 0...saves!.count - 1 {
                if result.contains(saves![i].day) == false {
                    result.append(saves![i].day)
                }
            }
            
            // 2022-08-25
            
            for i in result {
                if eventDay.contains(getDateToString(text: i)!) == false {
                    self.eventDay.append(getDateToString(text: i)!)
                }
            }
        
            return self.eventDay
        } else {
            return []
        }
                
        
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
    
    func setMonthMoneyData(save: Save) {
        let month = getMonthToString(date: save.day)
        
        monthMoney[month - 1] += Double(Int(save.saveMoney)!)
    }
    
    func setEachDayDate() {
        for i in (1...7).reversed() {
            let date = Date(timeIntervalSinceNow: -Double((86400 * (i - 1))))
            
            eachDayAndMoney[getStringToDate(date: date)] = Double(totalMoneyOfDate(date: date))
        }
    }
    
    func deleteMonthMoneyData(save: Save) {
        let month = getMonthToString(date: save.day)
        
        monthMoney[month - 1] -= Double(Int(save.saveMoney)!)
    }
    
    func setEachWeekendDate() {
        
        let interval = getDateForInt(date: Date())
        
        if interval != 7 {
            let sat = Date(timeIntervalSinceNow: Double(86400 * (7 - interval)))
            
            for i in (0...6).reversed() {
                let pastSat = Date(timeInterval: -(Double((604800) * i)), since: sat)
                
                EachWeekendDayAndMoney[getStringToDate(date: pastSat)] = setWeekendMoney(date: pastSat)
            }
            
        } else {
            for i in (0...6).reversed() {
                let pastSat = Date(timeInterval: -(Double((604800) * i)), since: Date())
                
                EachWeekendDayAndMoney[getStringToDate(date: pastSat)] = setWeekendMoney(date: pastSat)
            }
        }
    }
    
    func setWeekendMoney(date: Date) -> Double {
        
        let interval = getDateForInt(date: date)
        
        var result: Double = 0.0

        for i in 0...interval - 1 {
            let pastDate = Date(timeInterval: -(Double(86400 * i)), since: date)
            result += Double(totalMoneyOfDate(date: pastDate))
        }
        
        return result
    }
    
    func totalMoneyOfDate(date: Date) -> Int {
        
        let saves = self.returnSaveOfSelectedDay(date: getStringToDate(date: date))
        
        var result = 0
        
        for i in saves {
            result = result + Int(i.saveMoney)!
        }
        
        return result
    }
    
    func initializationAllData() {
        eventDay = [Date]()
        saveOfDay = [Save]()
        totalMoney = 0
        monthMoney = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        eachDayAndMoney = [String: Double]()
        UserDefaults.standard.set(0, forKey: "totalMoney")
        
        do {
            try realm.write {
                realm.delete(realm.objects(Save.self))
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
