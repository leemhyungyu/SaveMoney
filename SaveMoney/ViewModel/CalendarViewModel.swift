//
//  CalendarViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/20.
//

import UIKit
import RealmSwift

class CalendarViewModel {
    let saveManager = SaveManager.shared
    
    var day: String?
    var date: Date?
    
    var selectedSave: Save {
        return saveManager.selectedSave!
    }
    
    var todaySaveMoney: Int?
    
    var save: Results<Save> {
        return saveManager.saves!
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
    
    func setCalendarSubtitleData(date: Date) -> Int {
        
        let saves = saveManager.returnSaveOfSelectedDay(date: getStringToDate(date: date))
        
        var result = 0
        
        for i in saves {
            result = result + Int(i.saveMoney)!
        }
        
        return result
    }
    
    func setMonthData() {
        for i in save {
            saveManager.setMonthMoneyData(save: i)
        }
    }
    
    func setIndexOfSelectedSave(_ index: Int) {
        saveManager.setIndexOfSelectedSave(index)
    }
    
    func setSelectedDate() {
        saveManager.setSelectedDate(date!)
    }
    
    func setSelectedSave(_ save: Save) {
        saveManager.setSelctedSave(save)
    }
}
