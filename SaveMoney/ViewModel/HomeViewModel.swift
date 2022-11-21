//
//  HomeViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/11.
//

import Foundation
import RealmSwift

class HomeViewModel {
    
    // MARK: - ViewManager
    
    let saveManager = SaveManager.shared
    
    // MARK: - Properties
    
    var HomeCellData: [Home] = [.total, .month, .week]
    
    var save: Results<Save> {
        return saveManager.saves!
    }
    
    var saveOfDay: [Save] {
        return saveManager.saveOfDay
    }
    
//
//    var eachWeekendDayAndMoney: [String: Double] {
//        return saveManager.EachWeekendDayAndMoney
//    }
    
    var selectedSave: Save {
        return saveManager.selectedSave!
    }
    
    /// 총 저축 금액 중 가장 큰 Save객체
    var maxTotalSave: Save?
    /// 이번 달 저축 금액 중 가장 큰 Save 객체
    var maxThisMonthSave: Save?
    /// 이번 주 저축 금액 중 가장 큰 Save 객체
    var maxThisWeekendSave: Save?
    
    /// Cell의 개수
    var numOfCell: Int {
        return HomeCellData.count
    }
    
    /// 총 저축 금액 (원 단위)
    var totalMoney: String?
    /// 이번 달 저축 금액 (원 단위)
    var thisMonthMoney: String?
    /// 이번 주 저축 금액 (원 단위)
    var thisWeekendMoney: String?
    
    /// 주간 날짜를 순서대로 저장하는 객체
    var EachWeekendDate = [String]()
    /// 주간 저축 금액을 순서대로 저장하는 객체
    var EachWeekendMoney = [Double]()
    
    /// 오늘부터 90일전까지의 각 일마다의 저축 금액
    var moneyOfEachDayForThreeMonth: [Double] = Array(repeating: 0.0, count: 90)
    
    /// 오늘부터 90일전까지의 각 일마다의 날짜 정보
    var dateOfEachDayForThreeMonth: [String] = Array(repeating: "", count: 90)
    
    /// 오늘부터 12주전까지의 각 주차마다의 저축 금액
    var moneyOfEachWeekendForTwelfthWeek: [Double] = Array(repeating: 0.0, count: 12)
    
    /// 오늘부터 12주전까지의 각 주차마다의 날짜 정보
    var dateOfEachWeekendForTwelfthWeek: [String] = Array(repeating: "", count: 12)
    
    /// 일간, 주간, 월간 그래프를 표시하기 위한 Bool값
    var bool = [false, false, false]
    
    /// 오늘부터 12개월전까지의 각 월마다의 날짜 정보
    var dateOfEachMonthForTwelfthMonth: [String] = Array(repeating: "", count: 12)
    
    /// 오늘부터 12개월전까지의 각 월마다 저축 금액
    var moneyOfEachMonthForTwelfthMonth: [Double] = Array(repeating: 0.0, count: 12)
    
         
    // MARK: - Functions
    
    /// TableView의 Cell에 표시될 title을 리턴해주는 함수
    func titleOfCell(index: Int) -> String {
        return HomeCellData[index].title
    }
    
    /// TableView의 Cell에 표시될 금액을 리턴해주는 함수
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
    
    func detailInfo(_ section: Int) -> Save {
        switch section {
        case 0:
            if let maxTotalSave = maxTotalSave {
                setSelectedSave(save: maxTotalSave)
                return maxTotalSave
            } else {
                return Save()
            }
            
        case 1:
            setSelectedSave(save: maxThisMonthSave!)
            return maxThisMonthSave!
        case 2:
            setSelectedSave(save: maxThisWeekendSave!)
            return maxThisWeekendSave!
        default:
            return Save()
        }
    }
    
    func setSelectedSave(save: Save) {
        saveManager.setSlectedSaveForHomeVC(save)
    }
    
    func retrieve() {
        saveManager.retrieveSave()
    }

    func saveOfDate(date: String) {
        saveManager.saveOfSelectedDay(date: date)
    }
    
    /// 총 저축 금액 중 가장 큰 금액의 Save를 가져오는 함수
    func setMaxTotalMoney() {
        
        let save = save.sorted(by: {Int($0.saveMoney)! > Int($1.saveMoney)!})
                
        if save.count >= 1{
            maxTotalSave = save[0]
        } else {
            maxTotalSave = nil
        }
    }
    
    /// 이번 달 저축 금액 중 가장 큰 금액의 Save를 가져오는 함수
    func setThisMonthSaves() {
        let thisMonthSaves = save.filter { getMonthToString(date: $0.day) == getMonthToString(date: getStringToDate(date: Date()))}
        
        let save = thisMonthSaves.sorted(by: { Int($0.saveMoney)! > Int($1.saveMoney)!})
        
        
        if save.count >= 1 {
            maxThisMonthSave = save[0]
        } else {
            maxThisMonthSave = nil
        }
    }
    
    /// 이번 주 저축 금액 중 가장 큰 금액의 Save를 가져오는 함수
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
        
        setEachDayDate()
        setWeekendDayDate()
        setMonthDateAndMoney()
        
        saveManager.setEachMonthDate()
        
        setThisMonthSaves()
        setThisWeekendSaves()
        setMaxTotalMoney()
        
        self.thisWeekendMoney = setIntForWon(Int(moneyOfEachWeekendForTwelfthWeek.last!))
        
        self.thisMonthMoney = setIntForWon(Int(moneyOfEachMonthForTwelfthMonth.last!))
        
        if save.count >= 1 {
            totalMoney = setIntForWon(saveManager.totalMoney)
        } else {
            totalMoney = "0원"
        }
    }

    /// 주간 날짜와 저축 금액을 저장하는 함수
    func setWeekendDayDate() {
        let interval = getDateForInt(date: Date())
        
        // 오늘이 토요일이 아니면
        if interval != 7 {
            let sat = Date(timeIntervalSinceNow: Double(86400 * (7 - interval)))
            
            for i in (0...11).reversed() {
                let pastSat = Date(timeInterval: -(Double((604800) * (11 - i))), since: sat)
                
                moneyOfEachWeekendForTwelfthWeek[i] = setWeekendMoney(date: pastSat)
                dateOfEachWeekendForTwelfthWeek[i] = getWaveMonthDayForString(date: pastSat)
                
            }
        } else {
            for i in (0...11).reversed() {
                let pastSat = Date(timeInterval: -(Double((604800) * (11 - i))), since: Date())
                
                moneyOfEachWeekendForTwelfthWeek[i] = setWeekendMoney(date: pastSat)
                dateOfEachWeekendForTwelfthWeek[i] = getWaveMonthDayForString(date: pastSat)
            }
        }
    }
    
    /// 오늘을 기점으로 90일 전까지의 날짜와 저축 금액을 저장하는 함수
    func setEachDayDate() {
                
        for i in (0...89) {
            let date = Date(timeInterval: -(86400*Double(89 - i)), since: Date.now)
            
            dateOfEachDayForThreeMonth[i] = getMonthAndDayForString(date: date)
                        
            moneyOfEachDayForThreeMonth[i] = Double(saveManager.totalMoneyOfDate(date: date))
            
        }
    }
    
    /// 오늘을 기점으로 12개월 전까지의 날짜와 저축 금액을 저장하는 함수
    func setMonthDateAndMoney() {
        
        
        let todayMonth = Int(getMonthToDate(date: Date.now))!
        
        for i in 1...12 {
        
            let temp = 12 - i - todayMonth
            var month: Int
            
            if temp < 0 {
                month = abs(temp)
            } else if temp == 0 {
                month = 12
            } else {
                month = 12 - temp
            }
            
            dateOfEachMonthForTwelfthMonth[i - 1] =
            "\(month)월"
            
            let monthSave: [Save] = save.filter { getMonthToString(date: $0.day) == month }
            
            var monthMoney = 0.0
            
            monthSave.forEach {
                monthMoney += Double($0.saveMoney)!
            }
            
            moneyOfEachMonthForTwelfthMonth[i - 1] = monthMoney
        }
    }
    
    /// 입력받은 날짜를 기점으로 일주일전까지의 저축 금액을 더해서 리턴해주는 함수
    func setWeekendMoney(date: Date) -> Double {
        
        let interval = getDateForInt(date: date)
        
        var result: Double = 0.0

        for i in 0...interval - 1 {
            let pastDate = Date(timeInterval: -(Double(86400 * i)), since: date)
            result += Double(saveManager.totalMoneyOfDate(date: pastDate))
        }
        
        return result
    }
}

