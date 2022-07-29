//
//  Date.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//
import Foundation

func getDateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "Y년 M월 dd일"
    
    return dateFormatter.string(from: date)
}

func getStringToDate(text: String) -> Date? {
    let dateFormatter = DateFormatter()
    // YYYY년 MM년 DD일 -> YYYY-MM-dd로 바꿔야함
    
    
    dateFormatter.dateFormat = "Y년 M월 dd일"
    
    let day = dateFormatter.date(from: text)
    
    return day!
}
