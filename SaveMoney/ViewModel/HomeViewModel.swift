//
//  HomeViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/11.
//

import Foundation

class HomeViewModel {
    
    let saveManager = SaveManager.shared
    
    var save: [Save] {
        return saveManager.saves
    }
    
    var saveOfDay: [Save] {
        return saveManager.saveOfDay
    }
    
    var monthMoney: [Double] {
        return saveManager.monthMoney
    }
    
    var eachDayAndMoney: [String: Double] {
        return saveManager.eachDayAndMoney
    }
    
    var eachWeekendDayAndMoney: [String: Double] {
        return saveManager.EachWeekendDayAndMoney
    }
    
    var maxThisMonthMoney: String {
        return saveManager.maxThisMonthMoney
    }
    
    var maxThisWeekendMoney: String {
        return saveManager.maxThisWeekendMoney
    }
    
    var maxThisMonthSave: Save {
        return saveManager.maxThisMonthSave!
    }
    
    var maxThisWeekendSave: Save {
        return saveManager.maxThisWeekendSave!
    }
    
    var numOfCell: Int {
        return 1
    }
    
    var totalMoney: String?
    var maxSaveMoney: String?

    var thisMonthMoney: String?
    var thisWeekendMoney: String?
    
    var day = [String]()
    var EachDayDate = [String]()
    var EachDayMoney = [Double]()
    
    var EachWeekend = [String]()
    var EachWeekendDate = [String]()
    var EachWeekendMoney = [Double]()
    
    let month = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
        
    func retrieve() {
        saveManager.retrieveSave()
    }

    func saveOfDate(date: String) {
        saveManager.saveOfSelectedDay(date: date)
    }
    
    func setMonthData() {
        for i in save {
            saveManager.setMonthMoneyData(save: i)
        }
    }
    
    func setMoneyData() {
        
        saveManager.setEachDayDate()
        saveManager.setEachWeekendDate()
        saveManager.setThisMonthSaves()
        saveManager.setThisWeekendSaves()
        
        self.thisMonthMoney = setIntForWon(Int((monthMoney[Int(getMonthToDate(date: Date()))! - 1])))
        self.thisWeekendMoney = setIntForWon(Int(eachWeekendDayAndMoney[getStringToDate(date: getSatToDate(date: Date()))]!))
        if save.count >= 1 {
            let save = save.sorted(by: { Int($0.saveMoney)! > Int($1.saveMoney)!})
            totalMoney = setIntForWon(saveManager.totalMoney)
            maxSaveMoney = setStringForWon(save[0].saveMoney)
        } else {
            totalMoney = "0원"
            maxSaveMoney = "0원"
        }
    }
    
    func setEachDayDate() {
        
        EachDayDate = [String]()
        EachDayMoney = [Double]()
        
        self.day = Array(eachDayAndMoney.keys).sorted(by: <)
        
        self.day.map { self.EachDayDate.append(getMonthAndDayForString(date: $0))
            self.EachDayMoney.append(eachDayAndMoney[$0]!)
        }
    }
    

    func setWeekendDayDate() {
        EachWeekendDate = [String]()
        EachWeekendMoney = [Double]()
        
        self.EachWeekend = Array(eachWeekendDayAndMoney.keys).sorted(by: <)
        
        self.EachWeekend.map {
            self.EachWeekendDate.append(getWaveMonthDayForString(date: getDateToString(text: $0)!))
            
            self.EachWeekendMoney.append(eachWeekendDayAndMoney[$0]!)
        }
    }
}

