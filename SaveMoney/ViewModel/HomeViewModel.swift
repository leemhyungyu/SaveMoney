//
//  HomeViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/11.
//

import Foundation

class HomeViewModel {
    
    let saveManager = SaveManager.shared
    
    var HomeCellData: [Home] = [.total, .month, .week]
    
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
    
    var maxThisMonthSave: Save?
    var maxThisWeekendSave: Save?
    var maxTotalSave: Save?
        
    var numOfCell: Int {
        return HomeCellData.count
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
    
    var bool = [false, false, false]
    
    let month = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
        
    func titleOfCell(index: Int) -> String {
        return HomeCellData[index].title
    }
    
    func moneyOfCell(index: Int) -> String {
        switch index {
        case 0:
            return totalMoney!
        case 1:
            return thisMonthMoney!
        case 2:
            return thisWeekendMoney!
        default:
            return "0원"
        }
    }
    
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
    
    func setMaxTotalMoney() {
        let save = save.sorted(by: {Int($0.saveMoney)! > Int($1.saveMoney)!})
        
        if save.count >= 1{
            maxTotalSave = save[0]
        } else {
            maxTotalSave = nil
        }
    }
    
    func setThisMonthSaves() {
        let thisMonthSaves = save.filter { getMonthToString(date: $0.day) == getMonthToString(date: getStringToDate(date: Date()))}
        
        let save = thisMonthSaves.sorted(by: { Int($0.saveMoney)! > Int($1.saveMoney)!})
        
        
        if save.count >= 1 {
            maxThisMonthSave = save[0]
        } else {
            maxThisMonthSave = nil
        }
    }
    
    func setThisWeekendSaves() {
        let thisWeekendSaves = save.filter { getSatToString(date: getDateToString(text: $0.day)!) == getSatToString(date: Date()) }
        
        let save = thisWeekendSaves.sorted(by: { Int($0.saveMoney)! > Int($1.saveMoney)!} )
                
        if save.count >= 1 {
            maxThisWeekendSave = save[0]
        } else {
            maxThisWeekendSave = nil
        }
    }
    
    func setMoneyData() {
        
        saveManager.setEachDayDate()
        saveManager.setEachWeekendDate()
        setThisMonthSaves()
        setThisWeekendSaves()
        setMaxTotalMoney()
        
        self.thisMonthMoney = setIntForWon(Int((monthMoney[Int(getMonthToDate(date: Date()))! - 1])))
        self.thisWeekendMoney = setIntForWon(Int(eachWeekendDayAndMoney[getStringToDate(date: getSatToDate(date: Date()))]!))
        if save.count >= 1 {
            totalMoney = setIntForWon(saveManager.totalMoney)
        } else {
            totalMoney = "0원"
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

