//
//  SaveViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/20.
//

import UIKit
import FSCalendar
import SnapKit

class WeekendViewController: UIViewController {
    
    let viewModel = WeekendViewModel()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        return tableView
    }()
    
    lazy var weekCalendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.scope = .week
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.headerHeight = 50
        calendar.appearance.headerDateFormat = "YYYY년 M월"

        calendar.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)
        calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendar.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendar.weekdayHeight = 20

        calendar.backgroundColor = .white
        calendar.appearance.borderSelectionColor = .gray
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.titleWeekendColor = .red
        return calendar
    }()
    
    lazy var backBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrow.left")
        config.imagePadding = 10
        let btn = UIButton(configuration: config)
        btn.tintColor = .systemPink
        btn.addTarget(self, action: #selector(backBtnClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var saveBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemPink
        config.image = UIImage(systemName: "plus.circle.fill")
        config.imagePadding = 10
        
        var titleAttr = AttributedString.init("입력하기")
        titleAttr.font = .systemFont(ofSize: 16, weight: .semibold)
        config.attributedTitle = titleAttr
        
        let btn = UIButton(configuration: config)
        
        btn.addTarget(self, action: #selector(inputBtnClicked(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    var delegate: SendDataDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        configureUI()
        dateSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.retrieve()
        tableView.reloadData()
    }
    
    func configureUI() {
        
        view.addSubview(tableView)
        view.addSubview(weekCalendar)
        view.addSubview(saveBtn)
        
        weekCalendar.delegate = self
        weekCalendar.dataSource = self
        
        weekCalendar.appearance.borderSelectionColor = .red
        weekCalendar.appearance.selectionColor = .systemPink
        weekCalendar.appearance.todayColor = .systemGray4
        weekCalendar.appearance.weekdayTextColor = .lightGray
        
        weekCalendar.addSubview(backBtn)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SaveCell.self, forCellReuseIdentifier: SaveCell.identifier)
        
        weekCalendar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        backBtn.snp.makeConstraints {
            $0.top.equalTo(weekCalendar).offset(10)
            $0.leading.equalTo(weekCalendar).offset(5)
        }
    
        tableView.snp.makeConstraints {
            $0.top.equalTo(saveBtn.snp.bottom).offset(10)
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
        saveBtn.snp.makeConstraints {
            $0.top.equalTo(weekCalendar.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
    }
    
    @objc func backBtnClicked(_ sender: UITapGestureRecognizer) {
        if let data = weekCalendar.selectedDate {
            delegate?.sendData(data: data)
        }
        
        dismiss(animated: true)
    }
    
    @objc func inputBtnClicked(_ sender: UITapGestureRecognizer) {
        let InputVC = InputViewController()
        
        if let date = getDateToString(date: weekCalendar.selectedDate!) {
            InputVC.label.text = date
        } else {
            print("error")
        }
        present(InputVC, animated: true)
        
    }
}

extension WeekendViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let day = getDateToString(date: date)
        tableView.reloadData()
    }
}
extension WeekendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaveCell.identifier, for: indexPath) as? SaveCell else { return UITableViewCell() }
        
        var save: Save

        save = viewModel.saveOfDay[indexPath.row]
        
        cell.updateCell(save: save)
        
        return cell
    }
}

protocol SendDataDelegate {
    func sendData(data: Date)
}

extension WeekendViewController {
    func getDateToString(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "Y년 M월 dd일"
        
        return dateFormatter.string(from: date)
    }
    
    func dateSetting() {
        if weekCalendar.selectedDate == nil {
            weekCalendar.select(Date())
        }
    }
}
