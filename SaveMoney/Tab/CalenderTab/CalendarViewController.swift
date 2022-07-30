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
    private var collectionViewHeightConstraint: NSLayoutConstraint!
    var layout = UICollectionViewFlowLayout()
    var events: [Date] = []

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()

    lazy var collectionView: UICollectionView = {
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.identifier)
        
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        return collectionView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
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
    
    lazy var todayBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .systemPink
        
        var titleArr = AttributedString.init("Today")
        titleArr.font = .systemFont(ofSize: 16)
        
        config.attributedTitle = titleArr
        
        var btn = UIButton(configuration: config)
        
        btn.addTarget(self, action: #selector(todayBtnClicked), for: .touchUpInside)
        return btn
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
        getToday()
        setCollectionView()
        viewModel.eventInCalendar()
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        calendar.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if layout.collectionViewContentSize.height == 0 {
            collectionViewHeightConstraint.constant = 300
        } else {
            collectionViewHeightConstraint.constant = layout.collectionViewContentSize.height + 10
        }
     }
    
    @objc func todayBtnClicked() {
        calendar.select(Date())
        label.text = viewModel.selectedDay(Date())
        collectionView.reloadData()
        
        let day = getDateToString(date: Date())
        viewModel.saveOfSelectedDay(date: day)
        
        totalSaveMoney.text = "절약한 돈: " + viewModel.calTodaySaveMoney()
    }
    
    func setCollectionView() {
        collectionView.invalidateIntrinsicContentSize()
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 50)
        collectionViewHeightConstraint.isActive = true
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfCell
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as? MainCell else { return UICollectionViewCell() }
        
        let save = viewModel.saveOfDay[indexPath.row]
        
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
        label.text = viewModel.selectedDay(date)
        let day = getDateToString(date: date)
        viewModel.saveOfSelectedDay(date: day)
        totalSaveMoney.text = "절약한 돈: " + viewModel.calTodaySaveMoney()
        collectionView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        if viewModel.eventDay.contains(date) {
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(calendar)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(subView)
        scrollView.addSubview(todayBtn)
        
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
        calendar.appearance.eventDefaultColor = .systemPink

        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(700)
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.height.equalTo(300)
        }
        
        todayBtn.snp.makeConstraints {
            $0.centerY.equalTo(calendar.calendarHeaderView.snp.centerY)
            $0.trailing.equalTo(scrollView).offset(-20)
        }
        
        subView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).inset(-10)
            $0.width.equalTo(scrollView)
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
            $0.width.equalTo(scrollView)
        }
    }
    
    func getToday() {
        label.text = viewModel.selectedToday()
    }
    
    @objc func addBtnClicked(_ sender: UITapGestureRecognizer) {

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
