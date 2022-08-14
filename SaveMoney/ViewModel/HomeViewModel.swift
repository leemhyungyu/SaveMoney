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
    
    var totalMoney: String?
    var maxSaveMoney: String?
    var weekendMoney: String?
    var thisMonthMoney: String?
    
    var day = [String]()
    var EachDayDate = [String]()
    var EachDayMoney = [Double]()
    
    let month = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    var weekendDate: [Date] = []
    
    func retrieve() {
        saveManager.retrieveSave()
    }

    func saveOfDate(date: String) {
        saveManager.saveOfSelectedDay(date: date)
    }
    
    // 입력받은 Date의 절약한 값을 가져오는 함수
    func totalMoneyOfDate(date: Date) -> Int {
        
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
    
    
    func setMoneyData() {
        
        saveManager.setEachDayDate()
        
        self.thisMonthMoney = setIntForWon(Int((monthMoney[Int(getMonthToDate(date: Date()))!])))
        
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
            self.EachDayMoney.append(Double(totalMoneyOfDate(date: getDateToString(text: $0)!)))
        }
    }
}

