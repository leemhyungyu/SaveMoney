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
    var events: [Date]?
    var date: Date?
    
    var save: [Save] {
        return saveManager.saves
    }
    
    var numOfCell: Int {
        return save.count
    }
    
    func selectedDay(_ date: Date) -> String {
        self.day = getDateToString(date: date)
        
        return self.day!
    }
    
    func selectedToday() -> String {
        self.day = getDateToString(date: Date())
        
        return self.day!
    }
}
