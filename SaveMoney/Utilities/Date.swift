//
//  Date.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//
import Foundation

func getDateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "M월 dd일"
    
    return dateFormatter.string(from: date)
}


