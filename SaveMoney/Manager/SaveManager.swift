//
//  SaveManager.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/27.
//

import Foundation
import RealmSwift

class SaveManager {
    
    static let shared = SaveManager()
    
    private init () { }
    
    // MARK: - Properties

    let realm = try! Realm()
    
    /// 전체 Save객체
    var saves: Results<Save>?
    /// 이벤트 날짜들의 객체
    var eventDay = [Date]()
    /// view에서 선택된 날짜의 save객체들의 배열
    var saveOfDay = [Save]()
    /// view에서 선택된 Save 객체
    var selectedSave: Save?
    /// view에서 선택된 Save 객체의 날짜
    var selectedDate: Date?
    /// 업데이트하고 난 뒤 save객체
    var updateSave: Save?
    /// 선택된 Save객체의 인덱스 값
    var indexOfSelectedSave: Int?
    /// 총 저축 금액
    var totalMoney: Int = 0
    /// 달 별 저축 금액
    var monthMoney: [Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    /// 일주일간의 날짜와 저축 금액 딕셔너리 객체
    var eachDayAndMoney = [String: Double]()
    /// 주간 날짜와 저축 금액 딕셔너리 객체
    var EachWeekendDayAndMoney = [String: Double]()
    
    // MARK: - Function

    /// Save객체를 만들어서 리턴해주는 함수
    func createSave(day: String, planName: String, finalName: String, planMoney: String, finalMoney: String, category: String, check: Bool) -> Save {
        
        var nextId: Int = 0
        
        if saves!.count == 0 {
            nextId = nextId + 1
        } else {
            nextId = saves![saves!.index(before: saves!.endIndex)].id + 1
        }
        
        let saveMoney = Int(planMoney)! - Int(finalMoney)!
        
        return Save(id: nextId, day: day, planName: planName, planMoney: planMoney, finalName: finalName, finalMoney: finalMoney, saveMoney: String(saveMoney), category: category, check: check)
    }
    
    /// realm에 save객체를 추가해주는  함수
    func addSave(save: Save) {
        
        // realm을 읽어와서 받아온 save객체를 realm에 추가해줌
        try! realm.write {
            realm.add(save)
        }
        
        // 총 저축 금액을 더해주고 저장함
        totalMoney += Int(save.saveMoney)!
        UserDefaults.standard.set(totalMoney, forKey: "totalMoney")
    }

    
    /// 받아온 save객체를 realm에서 삭제해주는 함수
    func deleteSave(save: Save, index: Int) {
                
        totalMoney -= Int(saveOfDay[index].saveMoney)!
        UserDefaults.standard.set(totalMoney, forKey: "totalMoney")

        saveOfDay.remove(at: index)

        // 받아온 save객체의 id와 같은 realm객체를 찾음
        let selectData = realm.objects(Save.self).filter(NSPredicate(format: "id == %d", save.id)).first
        
        do {
            try realm.write {
                // realm에서 삭제
                realm.delete(selectData!)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        eventDay = setEventDay()
    }
    
    /// CalendarVC - CollectionView에서 선택한 Save객체의 정보를 저장하는 함수
    func setSelectedSave(save: Save, index: Int) {
        self.indexOfSelectedSave = index
        self.selectedSave = save
    }

    /// 달력에서 선택한 날짜를 저장하는 함수
    func setSelectedDate(_ date: Date) {
        self.selectedDate = date
    }
    
    /// 선택한 Save객체의 정보를 수정해주는 함수
    func updateSave(updateSave: Save, previousSave: Save) {
        
        self.updateSave = updateSave
        
        let previousSaveMoney = previousSave.saveMoney
        
        if let update = realm.objects(Save.self).filter(NSPredicate(format: "id = %d", previousSave.id)).first {
            try! realm.write {
                update.category = updateSave.category
                update.planName = updateSave.planName
                update.planMoney = updateSave.planMoney
                update.finalName = updateSave.finalName
                update.finalMoney = updateSave.finalMoney
                update.saveMoney = String(Int(updateSave.planMoney)! - Int(updateSave.finalMoney)!)
                update.check = updateSave.check
                self.updateTotalMoney(updateSaveMoney: update.saveMoney, previousSaveMoney: previousSaveMoney)
                print("업데이트 성공")
            }
        } else {
            print("업데이트 실패")
        }
    }
    
    /// Save객체 업데이트 시 총 저축 금액을 업데이트해주는 함수
    func updateTotalMoney(updateSaveMoney: String, previousSaveMoney: String) {
        
        let differenceMoney = Int(updateSaveMoney)! - Int(previousSaveMoney)!
    
        totalMoney += differenceMoney
        
        UserDefaults.standard.set(totalMoney, forKey: "totalMoney")
    }
    
    /// 달력에서 선택한 날짜의 Save객체의 배열들을 저장하는 함수
    func saveOfSelectedDay(date: String) {
        self.saveOfDay = saves!.filter { $0.day == date }
    }
    
    /// 달력에서 선택한 날짜의 Save객체의 배열들을 리턴해주는 함수
    func returnSaveOfSelectedDay(date: String) -> [Save] {
        return saves!.filter { $0.day == date }
    }
    
    /// 저장된 Save객체들과 총 저축 금액을 가져오는 함수
    func retrieveSave() {
        do {
            try realm.write {
                self.saves = realm.objects(Save.self)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        totalMoney = UserDefaults.standard.integer(forKey: "totalMoney")
    }
    
    /// 달력의 이벤트를 표시할 날짜를 리턴해주는 함수
    func setEventDay() -> [Date]{

        var result = [String]()
        eventDay = []

        if saves!.count >= 1 {
            for i in 0...saves!.count - 1 {
                if result.contains(saves![i].day) == false {
                    result.append(saves![i].day)
                }
            }
                        
            for i in result {
                if eventDay.contains(getDateToString(text: i)!) == false {
                    self.eventDay.append(getDateToString(text: i)!)
                }
            }
        
            return self.eventDay
        } else {
            return []
        }
    }
    
    /// 저장할 때 이벤트를 추가해주는 함수
    func addEventDay(date: String) {
        let date = getDateToString(text: date)
        
        if eventDay.contains(date!) == false {
            eventDay.append(date!)
        }
    }
    
    /// 저장할 때 saveOfDay 배열에 Save를 추가하는 함수
    func addSelectedDay(save: Save) {
        saveOfDay.append(save)
    }
    
    /// 오늘을 기점으로 일주일 전까지의 날짜와 저축 금액을 저장하는 함수
    func setEachDayDate() {
        for i in (1...7).reversed() {
            let date = Date(timeIntervalSinceNow: -Double((86400 * (i - 1))))
            
            eachDayAndMoney[getStringToDate(date: date)] = Double(totalMoneyOfDate(date: date))
        }
    }

    /// 달별로 저축 금액을 저장하는 함수
    func setEachMonthDate() {
        monthMoney = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        for i in saves! {
            let day = getMonthToString(date: i.day)
            
            monthMoney[day - 1] += Double(Int(i.saveMoney)!)
        }
    }
    
    /// 주별로 날짜와 저축 금액을 저장하는 함수
    func setEachWeekendDate() {
        
        let interval = getDateForInt(date: Date())
        
        if interval != 7 {
            let sat = Date(timeIntervalSinceNow: Double(86400 * (7 - interval)))
            
            for i in (0...6).reversed() {
                let pastSat = Date(timeInterval: -(Double((604800) * i)), since: sat)
                
                EachWeekendDayAndMoney[getStringToDate(date: pastSat)] = setWeekendMoney(date: pastSat)
            }
            
        } else {
            for i in (0...6).reversed() {
                let pastSat = Date(timeInterval: -(Double((604800) * i)), since: Date())
                
                EachWeekendDayAndMoney[getStringToDate(date: pastSat)] = setWeekendMoney(date: pastSat)
            }
        }
    }
    
    /// 입력받은 날짜를 기점으로 일주일전까지의 저축 금액을 더해서 리턴해주는 함수
    func setWeekendMoney(date: Date) -> Double {
        
        let interval = getDateForInt(date: date)
        
        var result: Double = 0.0

        for i in 0...interval - 1 {
            let pastDate = Date(timeInterval: -(Double(86400 * i)), since: date)
            result += Double(totalMoneyOfDate(date: pastDate))
        }
        
        return result
    }
    
    /// 입력받은 날짜의 저축 금액을 반환하는 함수
    func totalMoneyOfDate(date: Date) -> Int {
        
        let saves = self.returnSaveOfSelectedDay(date: getStringToDate(date: date))
        
        var result = 0
        
        for i in saves {
            result = result + Int(i.saveMoney)!
        }
        
        return result
    }
    
    /// 데이터를 초기화해주는 함수
    func initializationAllData() {
        eventDay = [Date]()
        saveOfDay = [Save]()
        totalMoney = 0
        monthMoney = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        eachDayAndMoney = [String: Double]()
        UserDefaults.standard.set(0, forKey: "totalMoney")
        
        do {
            try realm.write {
                realm.delete(realm.objects(Save.self))
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
