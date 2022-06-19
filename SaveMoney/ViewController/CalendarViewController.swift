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
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setting()
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func setting() {
 
        calendar.delegate = self
        calendar.dataSource = self
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 16)
        
        view.addSubview(calendar)
    
        view.backgroundColor = .white
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(400)
        }
    }
}
