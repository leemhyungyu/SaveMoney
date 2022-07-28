//
//  Save.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//

import UIKit
struct Save: Codable {
    var id: Int
    var day: String
    var planName: String
    var planMoney: String
    var finalName: String
    var finalMoney: String
    var saveMoney: String
    var category: String
//    var categoryImage: UIImageView
    
    mutating func update(day: String, planName: String, planMoney: String, finalName: String, finalMoney: String, category: String) {
        self.day = day
        self.planName = planName
        self.planMoney = planMoney
        self.finalName = finalName
        self.finalMoney = finalMoney
        self.category = category
//        self.categoryImage = categoryImage
    }
}
