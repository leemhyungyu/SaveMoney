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
    
    let saveMoney = numberFormatter.string(from: NSNumber(value: Int(text)!))!
    
    return saveMoney + "원"
}

// 정수를 입력받아 천단위로 ','넣고 '원' 붙혀주는 함수
func setIntForWon(_ text: Int) -> String {
    
    let value = String(text)
    
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    let saveMoney = numberFormatter.string(from: NSNumber(value: text))!
    
    return saveMoney + "원"
}
