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
    
    // MARK: - Proerties
    
    var HomeCellData: [Home] = [.total, .month, .week]
    
    var save: Results<Save> {
        return saveManager.saves!
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
    
    /// 일주일 간의 날짜를 순서대로 저장하는 객체
    /// eachDayAndMoney는 순서가 랜덤임
    var EachDayDate = [String]()
    /// 일주일 간의 저축 금액을 순서대로 저장하는 객체
    /// eachDayAndMoney는 순서가 랜덤임
    var EachDayMoney = [Double]()
    
    /// 주간 날짜를 순서대로 저장하는 객체
    var EachWeekendDate = [String]()
    /// 주간 저축 금액을 순서대로 저장하는 객체
    var EachWeekendMoney = [Double]()
    
    /// 일간, 주간, 월간 그래프를 표시하기 위한 Bool값
    var bool = [false, false, false]
    
    let month = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
        
    
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
        
        saveManager.setEachDayDate()
        saveManager.setEachWeekendDate()
        saveManager.setEachMonthDate()
        
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
    
    /// 일주일간의 날짜와 저축 금액을  저장하는 함수
    func setEachDayDate() {
        
        EachDayDate = [String]()
        EachDayMoney = [Double]()
        
        let day = Array(eachDayAndMoney.keys).sorted(by: <)
        
        day.map { self.EachDayDate.append(getMonthAndDayForString(date: $0))
            self.EachDayMoney.append(eachDayAndMoney[$0]!)
        }
    }

    /// 주간 날짜와 저축 금액을 저장하는 함수
    func setWeekendDayDate() {
        EachWeekendDate = [String]()
        EachWeekendMoney = [Double]()
        
        let eachWeekend = Array(eachWeekendDayAndMoney.keys).sorted(by: <)
        
        eachWeekend.map {
            self.EachWeekendDate.append(getWaveMonthDayForString(date: getDateToString(text: $0)!))
            
            self.EachWeekendMoney.append(eachWeekendDayAndMoney[$0]!)
        }
    }
}

