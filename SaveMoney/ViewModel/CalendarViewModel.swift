//
//  CalendarViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/20.
//

import UIKit

struct Save: Codable {
    var id: Int
    var day: String
    var planName: String
    var planMoney: String
    var finalName: String
    var finalMoney: String
    var saveMoney: String
    
    mutating func update(day: String, planName: String, planMoney: String, finalName: String, finalMoney: String) {
        self.day = day
        self.planName = planName
        self.planMoney = planMoney
        self.finalName = finalName
        self.finalMoney = finalMoney
        
       }
    
}

class CalendarViewModel {
    
    static let shared = CalendarViewModel()
    
    // Save객체를 저장할 리스트
    var saves: [Save] = []
    
    static var lastId: Int = 0
    
    // 행의 개수를 반환하는 메소드
    var numOfRow: Int {
        return saves.count
    }
    
    // Save 객체를 만드는 메소드
    func createSave(day: String, planName: String, finalName: String, planMoney: String, finalMoney: String) -> Save {
        
        let nextId = CalendarViewModel.lastId + 1
        CalendarViewModel.lastId = nextId
        
        let saveMoney = Int(planMoney)! - Int(finalMoney)!
        
        return Save(id: nextId, day: day, planName: planName, planMoney: planMoney, finalName: finalName, finalMoney: finalMoney, saveMoney: String(saveMoney))
    }
    

    // 절약내역을 추가하는 메소드
    func addSave(save: Save) {
        saves.append(save)
        saveStruct()
    }
    
    // 절약내역을 저장하는 메소드 (일단 userDefaults 사용)
    func saveStruct() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(saves), forKey: "Saves")
    }
    
    // 선택한 절약내역을 지우는 메소드
    func deleteSave(save: Save) {
        // 선택한 절약내역의 id와 다른 id를 가진 save객체만 선별
        saves = saves.filter { $0.id != save.id }
        // 저장
        saveStruct()
    }
    
    func retrieveSave() {
        guard let data = UserDefaults.standard.data(forKey: "Saves") else { return }
        saves = (try? PropertyListDecoder().decode([Save].self, from: data))!
        
        print(saves)
    }
}


