//
//  Function.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/29.
//
import Foundation

// 문자열을 입력받아 천단위로 ','넣고 '원' 붙혀주는 함수
func setStringForWon(_ text: String) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    let result = numberFormatter.string(from: NSNumber(value: Int(text)!))!
    
    return result + "원"
}

// 정수를 입력받아 천단위로 ','넣고 '원' 붙혀주는 함수
func setIntForWon(_ text: Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    let result = numberFormatter.string(from: NSNumber(value: text))!
    
    return result + "원"
}

func setIntForCommaPlus(_ text: Int) -> String {
    
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    let result = numberFormatter.string(from: NSNumber(value: text))!

    return "+" + result
}

func setInForCommaMinus(_ text: Int) -> String {
    let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
    let result = numberFormatter.string(from: NSNumber(value: text))!

    return "-" + result
}

// 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 
