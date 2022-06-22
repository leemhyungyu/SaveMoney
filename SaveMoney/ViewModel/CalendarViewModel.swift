//
//  CalendarViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/20.
//

import UIKit

struct Save {
    var day: String
    var category: String
    var name: String
    var money: Int
    var saveMoney: Int
    
    mutating func update(day: String, category: String, name: String, money: Int, saveMoney: Int) {
        self.day = day
        self.category = category
        self.name = name
        self.money = money
    }
}

class CalendarViewModel {
    
    var saves: [Save] = []
    
}

    
/*
 - 절약한 내용을 담을 객체
 [x] 해당 날짜
 [x] 물품의 카테고리
 [] 원래 결제하려했던 물품의 이름
 [x] 결국에 결제한 물품의 이름
 [] 원래 결제하려했던 가격
 [x] 결국에 결제한 가격
 [x] 세이브한 가격
 [] 이벤트가 있는 날인지 아닌지 구분하는 프로퍼티
 
 - 함수
 [] 이벤트가 있는 달력과 이벤트가 없는 달력을 구분지어서 화면 표시
 []
 */
