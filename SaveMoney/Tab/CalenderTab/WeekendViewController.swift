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
        
        calendar.appearance.borderSelectionColor = .gray
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.titleWeekendColor = .red
        return calendar
    }()
    
    let backBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrow.left")
        config.baseBackgroundColor = .black
        config.imagePadding = 10
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(backBtnClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    var saveBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.image = UIImage(systemName: "plus.circle.fill")
        config.imagePadding = 10
        
        var titleAttr = AttributedString.init("입력하기")
        titleAttr.font = .systemFont(ofSize: 16)
        config.attributedTitle = titleAttr
        
        let btn = UIButton(configuration: config)
        
        btn.addTarget(self, action: #selector(inputBtnClicked(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    let label: UILabel = {
        var label = UILabel()
        label.text = "어떤 것을 절약하셨나요?"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    var delegate: SendDataDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setting()
        dateSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.retrieve()
        tableView.reloadData()
    }
    
    func setting() {
        
        view.addSubview(label)
        view.addSubview(tableView)
        view.addSubview(weekCalendar)
        view.addSubview(saveBtn)
        
        weekCalendar.delegate = self
        weekCalendar.dataSource = self
        
        weekCalendar.addSubview(backBtn)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SaveCell.self, forCellReuseIdentifier: SaveCell.identifier)
        
        weekCalendar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        backBtn.snp.makeConstraints {
            $0.top.equalTo(weekCalendar).offset(10)
            $0.leading.equalTo(weekCalendar).offset(5)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
        }
    
        tableView.snp.makeConstraints {
            $0.top.equalTo(saveBtn.snp.bottom).offset(10)
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
        saveBtn.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
    }
    
    @objc func backBtnClicked(_ sender: UITapGestureRecognizer) {
        print("Back Btn Clicked")
        
        if let data = weekCalendar.selectedDate {
            delegate?.sendData(data: data)
        }
        
        dismiss(animated: true)
    }
    
    @objc func inputBtnClicked(_ sender: UITapGestureRecognizer) {
        let InputVC = InputViewController()

        InputVC.modalPresentationStyle = .fullScreen
        
        if let date = getDateToString(date: weekCalendar.selectedDate!) {
            InputVC.label.text = date
            print(weekCalendar.selectedDate)
        } else {
            print("error")
        }
//        print("saveVC - \(viewModel.saves)")
        present(InputVC, animated: true)
        
    }
}

extension WeekendViewController: FSCalendarDelegate, FSCalendarDataSource {
    
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

        save = viewModel.saves[indexPath.row]

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
        
        dateFormatter.dateFormat = "M월 dd일"
        
        return dateFormatter.string(from: date)
    }
    
    func dateSetting() {
        if weekCalendar.selectedDate == nil {
            weekCalendar.select(Date())
        }
    }
}
