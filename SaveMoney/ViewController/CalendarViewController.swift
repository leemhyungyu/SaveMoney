//
//  CalendarViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//

import UIKit
import FSCalendar
import SnapKit

class CalendarViewController: UIViewController {
//    var dateFormatter = DateFormatter()
//
//    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()

    
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
        setting()
    }
}
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as? MainCell else { return UITableViewCell() }
        
        return cell
    }
}
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func setting() {
 
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)
        calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendar.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.titleWeekendColor = .red


        view.addSubview(calendar)
        calendar.backgroundColor = .white
        view.backgroundColor = .white
            
        view.addSubview(tableView)
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(400)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).inset(-10)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("\(date) 날짜가 선택되었습니다.")
    }
}
