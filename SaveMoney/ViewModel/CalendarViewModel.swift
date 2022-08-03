//
//  CalendarViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/20.
//

import UIKit

class CalendarViewModel {
    let saveManager = SaveManager.shared
    let inputViewModel = InputViewModel.shared
    
    var day: String?
    var date: Date?
//    var saveOfDay: [Save] = []
    
    var todaySaveMoney: Int?
    
    var save: [Save] {
        return saveManager.saves
    }

    var eventDay: [Date] {
        return saveManager.eventDay
    }
    
    var saveOfDay: [Save] {
        return saveManager.saveOfDay
    }
    
    var numOfCell: Int {
        return saveOfDay.count
    }
    
    func selectedDay(_ date: Date) -> String {
        self.day = getMonthAndDayForString(date: date)
        
        return self.day!
    }
    
    func selectedToday() -> String {
        self.day = getMonthAndDayForString(date: Date())

        return self.day!
    }
    
    func retrieve() {
        saveManager.retrieveSave()
    }
    
    func saveOfSelectedDay(date: String) {
        saveManager.saveOfSelectedDay(date: date)
    }
    
//    func deleteOfSelectedDay(save: Save, index: Int) {
//        saveManager.deleteSave(save: save)
//        self.saveOfDay.remove(at: index)
//    }
    func deleteOfSelectedDay(save: Save, index: Int) {
        saveManager.deleteSave(save: save, index: index)
    }
    
    func calTodaySaveMoney() -> String {
        
        var money: Int = 0
        
        for i in saveOfDay {
            money += Int(i.saveMoney)!
        }
        
        let result = setStringForWon(String(money))
        
        return result
    }
    
    func eventInCalendar() {
        saveManager.setEventDay()
    }
    
    func setCalendarEventData(date: Date) -> Int {
        
        var saves = saveManager.returnSaveOfSelectedDay(date: getStringToDate(date: date))
        
        var result: Int = 0
        
        for i in saves {
            result = result + Int(i.saveMoney)!
        }
        
        return result
    }
}
