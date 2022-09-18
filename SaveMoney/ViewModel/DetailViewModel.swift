//
//  DetailViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/09/14.
//

import Foundation

class DetailViewModel {
    
    // MARK: - ViewManager

    let saveManager = SaveManager.shared
    
    // MARK: - Properties

    /// view에서 선택된 날짜의 save객체들의 배열
    var saveOfDay: [Save] {
        return saveManager.saveOfDay
    }
    
    /// view에서 선택된 Save 객체
    var selectedSave: Save {
        return saveManager.selectedSave!
    }
    
    /// 선택된 Save객체의 인덱스 값
    var index: Int {
        return saveManager.indexOfSelectedSave!
    }
        
    // MARK: - Functions
    
    /// Save를 삭제하는 함수
    func deleteSave() {
        saveManager.deleteSave(save: saveOfDay[index], index: index)
    }
}


