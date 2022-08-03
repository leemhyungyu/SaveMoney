//
//  Alert.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/04.
//

enum Alert {
    case delete
    
    var title: String {
        switch self {
        case .delete: return "삭제 알림"
        }
    }
    
    var body: String {
        switch self {
        case .delete: return "정말 삭제하시겠습니까?"
        }
    }
}
