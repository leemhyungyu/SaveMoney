//
//  Function.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/29.
//
import Foundation
import UIKit

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

func setCategoryImage(_ save: Save) -> UIImage {
    if save.category == "교통비" {
        return UIImage(systemName: "car.fill")!
    } else if save.category == "음식" {
        return UIImage(systemName: "fork.knife")!
    } else if save.category == "취미" {
        return UIImage(systemName: "gamecontroller.fill")!
    } else if save.category == "커피" {
        return UIImage(systemName: "cup.and.saucer.fill")!
    } else if save.category == "생활" {
        return UIImage(systemName: "figure.walk")!
    } else if save.category == "기타" {
        return UIImage(systemName: "wrench.and.screwdriver.fill")!
    } else if save.category == "의류" {
        return UIImage(systemName: "tshirt.fill")!
    } else if save.category == "교육" {
        return UIImage(systemName: "book.fill")!
    } else if save.category == "저축" {
        return UIImage(systemName: "banknote.fill")!
    } else {
        return UIImage()
    }
}
