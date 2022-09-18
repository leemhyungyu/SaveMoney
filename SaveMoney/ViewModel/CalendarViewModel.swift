//
//  CalendarViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/20.
//

import UIKit
import RealmSwift

class CalendarViewModel {
    
    // MARK: - ViewManager
    
    let saveManager = SaveManager.shared
    
    // MARK: - Properties
        
    var selectedDate: Date {
        return saveManager.selectedDate!
    }
    
    // 선택된 Save 객체
    var selectedSave: Save {
        return saveManager.selectedSave!
    }
    
    /// 전체 Save 객체
    var save: Results<Save> {
        return saveManager.saves!
    }

    /// 이벤트 날짜들의 객체
    var eventDay: [Date] {
        return saveManager.eventDay
    }
    
    /// 선택된 날짜의 Save 배열
    var saveOfDay: [Save] {
        return saveManager.saveOfDay
    }
    
    /// cell의 갯수
    var numOfCell: Int {
        return saveOfDay.count
    }
    
    
    // MARK: - Functions
    
    /// Date를 받아와  날짜를 String으로 리턴해주는 함수 (M/D)
    func selectedDay(_ date: Date) -> String {
        return getMonthAndDayForString(date: date)
    }
    
    /// 오늘의 날짜를 String으로 리턴해주는 함수 (M/D)
    func selectedToday() -> String {
        return getMonthAndDayForString(date: Date())
    }
    
    /// 저장된 Save객체들과 총 저축 금액을 가져오는 함수
    func retrieve() {
        saveManager.retrieveSave()
    }
    
    /// 달력에서 선택한 날짜의 Save객체의 배열들을 저장하는 함수
    func saveOfSelectedDay(date: String) {
        saveManager.saveOfSelectedDay(date: date)
    }
    
    /// 삭제하는 Save객체와 해당 index를 받아와 삭제하는 함수
    func deleteOfSelectedDay(save: Save, index: Int) {
        saveManager.deleteSave(save: save, index: index)
    }
    
    /// 달력에서 선택한 날짜의 절약 금액을 리턴해주는 함수
    func setSaveMoneyOfDay() -> String {
        
        var money: Int = 0
        
        for i in saveOfDay {
            money += Int(i.saveMoney)!
        }
        
        let result = setStringForWon(String(money))
        
        return result
    }
    
    /// 달력의 이벤트를 표시할 날짜를 설정해주는 함수
    func setEventDay() {
        saveManager.setEventDay()
    }
    
    /// 이벤트에 표시될 Subtitle을 리턴해주는 함수
    func setCalendarSubtitleData(date: Date) -> String {
        
        let saves = saveManager.returnSaveOfSelectedDay(date: getStringToDate(date: date))
        
        var result = 0
        
        for i in saves {
            result = result + Int(i.saveMoney)!
        }
        
        return setIntForCommaPlus(result)
    }
    
    /// CollectionView에서 선택된 Save객체와 index정보를 저장하는 함수
    func setSelectedSave(save: Save, index: Int) {
        saveManager.setSelectedSave(save: save, index: index)
    }
    
    /// 달력에서 선택한 날짜를 저장하는 함수
    func setSelectedDate(_ date: Date) {
        saveManager.setSelectedDate(date)
    }
}
