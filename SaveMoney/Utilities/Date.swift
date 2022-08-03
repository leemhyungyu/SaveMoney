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

//func getMonthAndDayForDate(date: String) -> String {
//    
//    // date는 예를 들어 2022년 1월 5일임
//    // 이거를 년도만 제외하고 월 일로만 표현
//    
////    var result: String
////
////    for i in 5...date.count {
////        print(date[i])
////    }
//    
////    return result
//}
