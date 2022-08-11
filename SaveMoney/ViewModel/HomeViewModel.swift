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
    
    var totalMoney: String {
        return setIntForWon(saveManager.totalMoney!)
    }
    
    var maxSaveMoney: String?
    var weekendMoney: String?
    
    let day = ["일", "월", "화", "수", "목", "금", "토"]
    var weekendData: [Double] = [0, 0, 0, 0, 0, 0, 0]

    var weekendDate: [Date] = []
    
    func retrieve() {
        saveManager.retrieveSave()
    }

    func saveOfDate(date: String) {
        saveManager.saveOfSelectedDay(date: date)
    }
    
    func totalMoneyOfDate(date: Date) -> Int {
        
        let saves = saveManager.returnSaveOfSelectedDay(date: getStringToDate(date: date))
        
        var result = 0
        
        for i in saves {
            result = result + Int(i.saveMoney)!
        }
        
        return result
    }
    
    func setWeekendData() {
        var count = 0
        var calMoney = 0
        for i in weekendDate {
            let money = totalMoneyOfDate(date: i)
            self.weekendData[count] = (Double(money))
            calMoney += money
            count += 1
        }
        
        weekendMoney = setIntForWon(calMoney)
    }
    
    
    func setWeekendDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "Y-M-dd-e-E"
        
        let day = formatter.string(from: Date())
        
        let today = day.components(separatedBy: "-")
        
        let interval = Int(today[3])! // e (1 ~ 7) (sun ~ sat) // 5
        
        if interval >= 2 {
            for i in (1...interval).reversed() {
                let date = Date(timeIntervalSinceNow: -Double((86400 * (i - 1))))
                weekendDate.append(date)
            }
        } else { // interval < 2
            weekendDate.append(Date())
        }
    }
    
    func setMaxSaveMoney() {
        let save = save.sorted(by: { Int($0.saveMoney)! > Int($1.saveMoney)!})
        
        maxSaveMoney = setStringForWon(save[0].saveMoney)
    }
}

