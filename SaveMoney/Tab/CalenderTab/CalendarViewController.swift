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
    
    let viewModel = CalendarViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.identifier)
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        return collectionView
    }()
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        
        
        calendar.layer.shadowColor = UIColor.systemGray.cgColor
        calendar.layer.masksToBounds = false
        calendar.layer.shadowRadius = 7
        calendar.layer.shadowOpacity = 0.4
        calendar.layer.cornerRadius = 8
        return calendar
    }()
    
    let subView: UIView = {
        let subView = UIView()
        
        subView.layer.shadowColor = UIColor.systemGray.cgColor
        subView.layer.masksToBounds = false
        subView.layer.shadowRadius = 7
        subView.layer.shadowOpacity = 0.4
        subView.layer.cornerRadius = 8
        subView.backgroundColor = .white
        
        return subView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let totalSaveMoney: UILabel = {
        let label = UILabel()
        
        label.text = "오늘 절약한 돈: "
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var addBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemPink
        
        var titleAttr = AttributedString.init("절약하기")
        titleAttr.font = .systemFont(ofSize: 16)
        config.attributedTitle = titleAttr
        
        let btn = UIButton(configuration: config)
        
        
        btn.addTarget(self, action: #selector(addBtnClicked(_:)), for: .touchUpInside)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        viewModel.retrieve()
        print(viewModel.save)
        getToday()
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfCell
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as? MainCell else { return UICollectionViewCell() }
        
        var save = viewModel.saveOfDay[indexPath.row]
        
        cell.updateUI(save: save)
        
        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 10
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("\(viewModel.day) 날짜가 선택되었습니다.")
        label.text = viewModel.selectedDay(date)
        let day = getDateToString(date: date)
        viewModel.saveOfSelectedDay(date: day)
        print(viewModel.saveOfDay)
        collectionView.reloadData()
        
        totalSaveMoney.text = "절약한 돈: " + viewModel.calTodaySaveMoney()
    }
    
//    func setEvents() {
//        let dfMatter = DateFormatter()
//        dfMatter.locale = Locale(identifier: "ko_KR")
//        dfMatter.dateFormat = "yyyy-MM-dd"
//
//        // events
//        let myFirstEvent = dfMatter.date(from: "2022-06-20")
//        let mySecondEvent = dfMatter.date(from: "2022-06-21")
//
//        events = [myFirstEvent!, mySecondEvent!]
//    }
//
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//
//        if self.events.contains(date) {
//            return 1
//        } else {
//            return 0
//        }
//    }
}

extension CalendarViewController{
    func setting() {
 
        calendar.delegate = self
        calendar.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(calendar)
        view.addSubview(collectionView)
        view.addSubview(subView)
        subView.addSubview(label)
        subView.addSubview(totalSaveMoney)
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
        calendar.appearance.borderSelectionColor = .red
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.titleWeekendColor = .red
        calendar.appearance.selectionColor = .systemPink

        calendar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        subView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).inset(-10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(addBtn.snp.bottom).offset(20)
            $0.leading.equalTo(subView).inset(20)
        }
        
        totalSaveMoney.snp.makeConstraints {
            $0.top.equalTo(label)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        addBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(calendar.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).inset(-10)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    func getToday() {
        label.text = viewModel.selectedToday()
    }
    
    @objc func addBtnClicked(_ sender: UITapGestureRecognizer) {
        
        print("ADD Btn Clicked")
        
        let WeekendVC = WeekendViewController()
        WeekendVC.weekCalendar.select(calendar.selectedDate)
        WeekendVC.delegate = self
        WeekendVC.modalPresentationStyle = .fullScreen
        present(WeekendVC, animated: true, completion: nil)
    }
}

extension CalendarViewController: SendDataDelegate {
    func sendData(data: Date) {
        calendar.select(data)
        label.text = viewModel.selectedDay(data)
    }
}
