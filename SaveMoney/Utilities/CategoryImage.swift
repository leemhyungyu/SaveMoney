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
    case dress
    case study
    case save
    case etc
    
    var title: String {
        switch self {
        case .food:
            return "식비"
        case .transportation:
            return "교통비"
        case .hobby:
            return "취미"
        case .life:
            return "생필품"
        case .coffee:
            return "커피"
        case .dress:
            return "의류"
        case .study:
            return "교육"
        case .save:
            return "저축"
        case .etc:
            return "기타"
        }
    }
    
    var imageView: UIImage {
        switch self {
        case .food:
            return UIImage(systemName: "fork.knife")!
        case .transportation:
            return UIImage(systemName: "car.fill")!
        case .hobby:
            return UIImage(systemName: "gamecontroller.fill")!
        case .life:
            return UIImage(systemName: "figure.walk")!
        case .coffee:
            return UIImage(systemName: "cup.and.saucer.fill")!
        case .dress:
            return UIImage(systemName: "tshirt.fill")!
        case .study:
            return UIImage(systemName: "book.fill")!
        case .save:
            return UIImage(systemName: "banknote.fill")!
        case .etc:
            return UIImage(systemName: "car.fill")!

        }
    }
}
