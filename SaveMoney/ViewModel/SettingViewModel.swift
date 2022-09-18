//
//  MyPageViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/12.
//

import Foundation

enum settingList: CaseIterable {
    case initialization
    case source
    
    var title: String {
        switch self {
        case .initialization:
            return "모든 데이터 초기화"
        case .source:
            return "오픈 소스 라이브러리"
        }
    }
}

class SettingViewModel {
    
    // MARK: - ViewManager

    let saveManager = SaveManager.shared

    // MARK: - Properties
    
    let list: [settingList] = [.initialization, .source]
        
    var numOfCell: Int {
        return list.count
    }
    
    // MARK: - Functions

    /// TableView의 title을 반환하는 함수
    func titleOfcell(index: Int) -> String {
        return list[index].title
    }
    
    /// 데이터를 초기화 하는 함수
    func initializationData() {
        print("initializationData - called")
        saveManager.initializationAllData()
    }
}
