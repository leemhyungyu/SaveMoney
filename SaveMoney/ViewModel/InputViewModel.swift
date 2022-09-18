//
//  InputViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//

import Foundation
import UIKit
import RealmSwift

class InputViewModel {
    
    // MARK: - ViewManager

    let saveManager = SaveManager.shared

    // MARK: - Proerties

    let categories: [Category] = [.food, .transportation, .hobby, .life, .coffee, .dress, .study, .save, .etc]

    /// 구매 여부를 판단하는 Bool 값
    var checkBoxData: Bool?
    
    /// view에서 선택된 Save 객체의 날짜
    var date: Date {
        return saveManager.selectedDate!
    }
    
    /// 전체 Save객체
    var saves: Results<Save> {
        return saveManager.saves!
    }
    
    /// 이벤트 날짜들의 객체
    var eventDay: [Date] {
        return saveManager.eventDay
    }
    
    /// view에서 선택된 Save 객체
    var selectedSave: Save {
        return saveManager.selectedSave!
    }
    
    /// 업데이트하고 난 뒤 save객체
    var updateSave: Save {
        return saveManager.updateSave!
    }
    
    /// 선택된 Save객체의 인덱스 값
    var indexOfSelectedSave: Int {
        return saveManager.indexOfSelectedSave!
    }
    
    // MARK: - Functions
    
    /// Save객체를 만들어서 리턴해주는 함수
    func createSave(date: Date, planName: String, finalName: String, planMoney: String, finalMoney: String, category: String, check: Bool) -> Save {
        return saveManager.createSave(day: getStringToDate(date: date), planName: planName, finalName: finalName, planMoney: planMoney, finalMoney: finalMoney, category: category, check: check)
    }
    
    /// 저장할 때 이벤트를 추가해주는 함수
    func addEventDay(save: Save) {
        // realm에 save객체를 추가해주는 함수
        saveManager.addSave(save: save)
        // 이벤트를 추가해주는 함수
        saveManager.addEventDay(date: save.day)
        // saveOfDay 배열에 Save를 추가하는 함수
        saveManager.addSelectedDay(save: save)
    }

    /// 받아온 selectedSave를 받아온 Save객체로 수정하는 함수
    func updateSave(save: Save) {
        saveManager.updateSave(updateSave: save, previousSave: selectedSave)
    }
    
    /// 수정하기 버튼을 누르면 SelectedSave를 updateSave로 바꿔주는 함수
    func updateSelectedSave() {
        saveManager.setSelectedSave(save: self.updateSave, index: indexOfSelectedSave)
    }
    
    /// 업데이트된 값들을 받아와 Save객체로 만들어 반환하는 함수
    func setUpdateSave(planName: String, finalName: String, planMoney: String, finalMoney: String, category: String, check: Bool) -> Save {
        
        let saveMoney = Int(planMoney)! - Int(finalMoney)!
        
        return Save(id: selectedSave.id, day: getStringToDate(date: self.date), planName: planName, planMoney: planMoney, finalName: finalName, finalMoney: finalMoney, saveMoney: String(saveMoney), category: category, check: check)
    }
}
