//
//  Alert.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/04.
//

enum Alert {
    case delete
    case initialization
    
    var title: String {
        switch self {
        case .delete: return "삭제 알림"
        case .initialization: return "데이터 삭제"
        }
    }
    
    var body: String {
        switch self {
        case .delete: return "정말 삭제하시겠습니까?"
        case .initialization: return "삭제한 데이터는 되돌릴 수 없습니다.\n그래도 삭제하시겠습니까?"
        }
    }
}
