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

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        
        return calendar
    }()
    
    let subView: UIView = {
        let subView = UIView()
        
        return subView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        
        label.text = "6월 19일"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let addBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        
        var titleAttr = AttributedString.init("절약하기")
        titleAttr.font = .systemFont(ofSize: 16)
        config.attributedTitle = titleAttr
        
        let btn = UIButton(configuration: config)
        
        btn.addTarget(self, action: #selector(addBtnClicked(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    var day: String!
    var events: [Date] = []
    var date: Date!

    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        setEvents()
        getToday()
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as? MainCell else { return UITableViewCell() }
        
        return cell
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("\(date) 날짜가 선택되었습니다.")
        day = getDateToString(date: date)
        label.text = day
    }
    
    func setEvents() {
        let dfMatter = DateFormatter()
        dfMatter.locale = Locale(identifier: "ko_KR")
        dfMatter.dateFormat = "yyyy-MM-dd"
        
        // events
        let myFirstEvent = dfMatter.date(from: "2022-06-20")
        let mySecondEvent = dfMatter.date(from: "2022-06-21")
        
        events = [myFirstEvent!, mySecondEvent!]
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        if self.events.contains(date) {
            return 1
        } else {
            return 0
        }
    }
}

extension CalendarViewController{
    func setting() {
 
        calendar.delegate = self
        calendar.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)

        view.addSubview(calendar)
        view.addSubview(tableView)
        view.addSubview(subView)
        subView.addSubview(label)
        subView.addSubview(addBtn)
        
        view.backgroundColor = .white
        calendar.backgroundColor = .white
        
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)
        calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendar.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendar.weekdayHeight = 20
        calendar.appearance.borderSelectionColor = .gray
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.titleWeekendColor = .red
        

        calendar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        subView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).inset(-10)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(subView)
            $0.leading.equalTo(subView).inset(20)
        }
        
        addBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(label.snp.bottom).inset(-20)
            $0.leading.equalTo(subView).inset(20)
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).inset(-10)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    func getDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "M월 dd일"
        
        return dateFormatter.string(from: date)
    }
    
    func getToday() {
        day = getDateToString(date: Date())
        
        label.text = day
    }
    @objc func addBtnClicked(_ sender: UITapGestureRecognizer) {
        
        print("ADD Btn Clicked")
        
        let SaveVC = SaveViewController()
        SaveVC.weekCalendar.select(calendar.selectedDate)
        SaveVC.delegate = self
        SaveVC.modalPresentationStyle = .fullScreen
        present(SaveVC, animated: true, completion: nil)
    }
}

extension CalendarViewController: SendDataDelegate {
    func sendData(data: Date) {
        calendar.select(data)
        day = getDateToString(date: data)
        label.text = day
    }
}
