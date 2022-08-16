//
//  Date.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//
import Foundation

func getStringToDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "Y/M/dd"
    
    return dateFormatter.string(from: date)
}

func getMonthAndDayForString(date: Date) -> String {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "M/d"
    
    return dateFormatter.string(from: date)
}

func getDateToString(text: String) -> Date? {
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "Y/MM/dd"
        
    return dateFormatter.date(from: text)
}

func getMonthToString(date: String) -> Int {
   
    let day = date.components(separatedBy: "/")
    
    return Int(day[1])!
}

func getMonthAndDayForString(date: String) -> String {
    let date = date.components(separatedBy: "/")
    
    return date[1] + "/" + date[2]
}

func getWaveMonthDayForString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "~M/d"
    
    return dateFormatter.string(from: date)
}

func getMonthToDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "M"
    
    return dateFormatter.string(from: date)
}

func getDayToDate(date: Date) -> String {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "E"
    
    return dateFormatter.string(from: date)
}

func getMonthForInt(date: Date) -> Int {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "e"
    
    return Int(dateFormatter.string(from: date))!
}

func getDateToDay(day: String) -> Date {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "Y년 M월 dd일 E요일"
    
    return dateFormatter.date(from: day)!
}
