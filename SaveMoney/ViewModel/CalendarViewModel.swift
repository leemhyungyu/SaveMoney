//
//  CalendarViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/20.
//

import UIKit

class CalendarViewModel {
    let saveManager = SaveManager.shared
    
    var day: String?
    var date: Date?
    var saveOfDay: [Save] = []
    
    var todaySaveMoney: Int?
    
    var save: [Save] {
        return saveManager.saves
    }

    var eventDay: [Date] {
        return saveManager.eventDay
    }
    
    var numOfCell: Int {
        return saveOfDay.count
    }
    
    func selectedDay(_ date: Date) -> String {
        self.day = getDateToString(date: date)
        
        return self.day!
    }
    
    func selectedToday() -> String {
        self.day = getDateToString(date: Date())

        return self.day!
    }
    
    func retrieve() {
        saveManager.retrieveSave()
    }
    
    func saveOfSelectedDay(date: String) {
        self.saveOfDay = saveManager.saveOfSelectedDay(date: date)
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
}
