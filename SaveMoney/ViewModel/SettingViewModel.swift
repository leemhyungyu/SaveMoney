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
    
    let list: [settingList] = [.initialization, .source]
    
    let saveManager = SaveManager.shared
    
    var numOfCell: Int {
        return list.count
    }
    
    func titleOfcell(index: Int) -> String {
        return list[index].title
    }
    
    func initializationData() {
        print("initializationData - called")
        saveManager.initializationAllData()
    }
}
