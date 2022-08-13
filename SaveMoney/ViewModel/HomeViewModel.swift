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
    var totalMoney: String?
    var maxSaveMoney: String?
    var weekendMoney: String?
    var thisMonthMoney: String?
    
    let day = ["일", "월", "화", "수", "목", "금", "토"]
    let month = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    var weekendData: [Double] = [0, 0, 0, 0, 0, 0, 0]

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
    
    // 일주일의 절약한 값의 합해서 저장하는 함수
    func setWeekendData() {
        var count = 0
        var calMoney = 0
        for i in weekendDate {
            let money = totalMoneyOfDate(date: i)
            print(money)
            self.weekendData[count] = (Double(money))
            print(weekendData)
            calMoney += money
            count += 1
        }
        
        weekendMoney = setIntForWon(calMoney)
    }
    
    func setMonthData() {
        for i in save {
            print(i.day)
            saveManager.setMonthMoneyData(save: i)
        }
    }
    
    func setWeekendDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "Y-M-dd-e-E"
        
        let day = formatter.string(from: Date())
        
        let today = day.components(separatedBy: "-")
        
        let interval = Int(today[3])! // e (1 ~ 7) (sun ~ sat) // 5
        print(interval)
        if interval >= 2 {
            for i in (1...interval).reversed() {
                let date = Date(timeIntervalSinceNow: -Double((86400 * (i - 1))))
                
                weekendDate.append(date)
            }
        } else { // interval < 2
            print(Date())
            weekendDate.append(Date())
        }
    }
    
    func setMoneyData() {
        
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
}

