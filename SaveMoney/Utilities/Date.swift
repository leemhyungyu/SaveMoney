//
//  Date.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//
import Foundation

func getStringToDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "Y년 M월 dd일"
    
    return dateFormatter.string(from: date)
}

func getMonthAndDayForString(date: Date) -> String {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "M월 d일"
    
    return dateFormatter.string(from: date)
}

func getDateToString(text: String) -> Date? {
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "Y년 M월 dd일"
        
    return dateFormatter.date(from: text)
}

func getDayToDate(date: Date) -> String {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "E"
    
    return dateFormatter.string(from: date)
}

func getDateToDay(day: String) -> Date {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "Y년 M월 dd일 E요일"
    
    return dateFormatter.date(from: day)!
}
