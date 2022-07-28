//
//  CategoryImage.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/28.
//

import UIKit

enum Category: CaseIterable {
    case food
    case transportation
    case hobby
    case life
    case coffee
    case etc
    
    var title: String {
        switch self {
        case .food:
            return "음식"
        case .transportation:
            return "교통"
        case .hobby:
            return "취미"
        case .life:
            return "생활"
        case .coffee:
            return "커피"
        case .etc:
            return "기타"
        }
    }
    
}
