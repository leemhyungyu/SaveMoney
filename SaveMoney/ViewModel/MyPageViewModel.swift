//
//  MyPageViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/12.
//

import Foundation

enum myPage: CaseIterable {
    case initialization
    case goal
    case userInfo
    case source
    
    var title: String {
        switch self {
        case .initialization:
            return "모든 데이터 초기화"
        case .goal:
            return "목표 금액 수정하기"
        case .userInfo:
            return "개인 정보 수정하기"
        case .source:
            return "오픈 소스 라이브러리"
        }
    }
}


class MyPageViewModel {
    
    let myPages: [myPage] = [.initialization, .goal, .userInfo, .source]
    
    let saveManager = SaveManager.shared
    
    var numOfCell: Int {
        return myPages.count
    }
    
    func titleOfcell(index: Int) -> String {
        return myPages[index].title
    }
    
    func initializationData() {
        print("initializationData - called")
        saveManager.initializationAllData()
    }
}
