//
//  Home.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/18.
//

import Foundation

enum Home {
    case total
    case month
    case week
    
    var title: String {
        switch self {
        case .total:
            return "총 저축 금액"
        case .month:
            return "이번 달 저축 금액"
        case .week:
            return "이번 주 저축 금액"
        }
    }
}
