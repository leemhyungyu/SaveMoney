//
//  Save.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//

import UIKit
import RealmSwift

//struct Save: Codable {
//    var id: Int
//    var day: String
//    var planName: String
//    var planMoney: String
//    var finalName: String
//    var finalMoney: String
//    var saveMoney: String
//    var category: String
//
//    mutating func update(day: String, planName: String, planMoney: String, finalName: String, finalMoney: String, category: String) {
//        self.day = day
//        self.planName = planName
//        self.planMoney = planMoney
//        self.finalName = finalName
//        self.finalMoney = finalMoney
//        self.category = category
//    }
//}

class Save: Object {

    @Persisted(primaryKey: true) var id: Int
    @Persisted var day: String
    @Persisted var planName: String
    @Persisted var planMoney: String
    @Persisted var finalName: String
    @Persisted var finalMoney: String
    @Persisted var saveMoney: String
    @Persisted var category: String
    @Persisted var check: Bool
    
    convenience init(id: Int, day: String, planName: String, planMoney: String, finalName: String, finalMoney: String, saveMoney: String, category: String, check: Bool) {

        self.init()
        self.id = id
        self.day = day
        self.planName = planName
        self.planMoney = planMoney
        self.finalName = finalName
        self.finalMoney = finalMoney
        self.saveMoney = saveMoney
        self.category = category
        self.check = check
    }
}
