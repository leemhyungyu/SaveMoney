//
//  Warning.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/12.
//

import Foundation

enum Warning: CaseIterable {
    case input
    case initialization
    
    var body: String {
        switch self {
        case .input:
            return "필수 정보를 모두 입력해주세요."
        case .initialization:
            return "모든 데이터가 삭제되었습니다."
        }
    }
    
}
