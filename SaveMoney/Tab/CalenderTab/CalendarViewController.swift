//
//  CalendarViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//
import UIKit
import FSCalendar
import SnapKit
import SwiftMessages

class CalendarViewController: UIViewController {
    
    let viewModel = CalendarViewModel()
    private var collectionViewHeightConstraint: NSLayoutConstraint!
    private var calendarViewHegihtconstraint: NSLayoutConstraint!
    private var lastContentOffset: CGFloat = 0.0
    var layout = UICollectionViewFlowLayout()
    var events: [Date] = []

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()

    lazy var collectionView: UICollectionView = {
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.identifier)
        
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: EmptyCell.identifier)
        
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        return collectionView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var monthButton: UIButton = {
        let btn = UIButton()
        
        btn.setButtonShape(title: "월간")
        btn.addTarget(self, action: #selector(monthButtonClicked), for: .touchUpInside)
        btn.isSelected = true
        return btn
    }()
    
    lazy var weekendButton: UIButton = {
        let btn = UIButton()
        
        btn.setButtonShape(title: "주간")
        btn.addTarget(self, action: #selector(weekendButtonClicked), for: .touchUpInside)
        btn.isSelected = false
        return btn
    }()
    
    let weekendLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.text = "주간"
        
        return label
    }()
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        
        calendar.layer.shadowColor = UIColor.systemGray.cgColor
        calendar.layer.masksToBounds = false
        calendar.layer.shadowRadius = 7
        calendar.layer.shadowOpacity = 0.4
        calendar.layer.cornerRadius = 8
        calendar.backgroundColor = .white
        
        return calendar
    }()
    
    let subView: UIView = {
        let subView = UIView()

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
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .systemPink
        
        var titleArr = AttributedString.init("절약하기")
        titleArr.font = .systemFont(ofSize: 16)
        
        config.attributedTitle = titleArr
        
        var btn = UIButton(configuration: config)
        
        btn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    lazy var settingButton: UIButton = {
        
        var button = UIButton()
        
        button.setSettingVCButton()
        
        button.addTarget(self, action: #selector(presentSettingViewController), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        setTabNavigationBar("캘린더")
        viewModel.retrieve()
        setDayData(Date())
        setHeigthConstraint()
        viewModel.eventInCalendar()
//        viewModel.setMonthData()
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.retrieve()
        reloadMainData()
        self.tabBarController?.tabBar.isHidden = false

    }
        
    override func viewWillLayoutSubviews() {
        
        if view.frame.size.height < calendarViewHegihtconstraint.constant + subView.frame.size.height + layout.collectionViewContentSize.height {
            
            collectionViewHeightConstraint.constant = layout.collectionViewContentSize.height + CGFloat(collectionView.numberOfItems(inSection: 0) * 10)
        } else {
            collectionViewHeightConstraint.constant = view.frame.size.height - calendarViewHegihtconstraint.constant - subView.frame.size.height
        }
     }
    
    @objc func todayBtnClicked() {
        calendar.select(Date())
        label.text = viewModel.selectedDay(Date())
        collectionView.reloadData()
        
        let day = getStringToDate(date: Date())
        viewModel.saveOfSelectedDay(date: day)
        
        totalSaveMoney.text = "절약한 돈: " + viewModel.calTodaySaveMoney()
    }
    
    @objc func weekendButtonClicked() {
        
        if weekendButton.isSelected == false && monthButton.isSelected == true {
            weekendButton.isSelected = !weekendButton.isSelected
            monthButton.isSelected = !monthButton.isSelected
        }
        
        calendar.scope = .week
    }
    
    @objc func monthButtonClicked() {
        if weekendButton.isSelected == true && monthButton.isSelected == false {
            weekendButton.isSelected = !weekendButton.isSelected
            monthButton.isSelected = !monthButton.isSelected
        }
        
        calendar.scope = .month

    }
    
    func setHeigthConstraint() {
        collectionView.invalidateIntrinsicContentSize()
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 50)
        collectionViewHeightConstraint.isActive = true
        
        calendar.invalidateIntrinsicContentSize()
        calendarViewHegihtconstraint = calendar.heightAnchor.constraint(equalToConstant: 350)
        calendarViewHegihtconstraint.isActive = true
    }
    
    
    func reloadMainData() {
        
        collectionView.reloadData()
        calendar.reloadData()
        totalSaveMoney.text = "절약한 돈: " + viewModel.calTodaySaveMoney()
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if viewModel.numOfCell == 0 {
            return 1
        } else {
            return viewModel.numOfCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as? MainCell else { return UICollectionViewCell() }
        
        guard let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCell.identifier, for: indexPath) as? EmptyCell else { return UICollectionViewCell() }
        
        if viewModel.numOfCell == 0 {
            return emptyCell
        } else {
            let save = viewModel.saveOfDay[indexPath.row]
            
            cell.updateUI(save: save)
            
            cell.cancleButtonClosure = {
                let alertViewController = self.presentAlertView(.delete)
                
                alertViewController.doneButtonClosure = {
                    self.viewModel.deleteOfSelectedDay(save: save, index: indexPath.item)
                    self.reloadMainData()
                }
                self.present(alertViewController, animated: true)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailVC = DetailViewController()
        
        DetailVC.detailView.setView(save: viewModel.saveOfDay[indexPath.row])
        
        viewModel.setSelectedSave(viewModel.saveOfDay[indexPath.row])
        
        viewModel.setIndexOfSelectedSave(indexPath.row)
        viewModel.setSelectedDate()
        self.navigationController?.pushViewController(DetailVC, animated: true)
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
        setDayData(date)
    }
    
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        if viewModel.eventDay.contains(date) {
            return setIntForCommaPlus(viewModel.setCalendarSubtitleData(date: date))
        } else {
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        if calendar.scope == .week {
            calendarViewHegihtconstraint.constant = bounds.height
        } else {
            calendarViewHegihtconstraint.constant = bounds.height
        }
    }
}

extension CalendarViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.y <= 50 {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
}

extension CalendarViewController{
    func setting() {
 
        calendar.delegate = self
        calendar.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        
        
        [
            monthButton,
            weekendButton,
            calendar,
            collectionView,
            subView,
            todayBtn,
            addBtn,
            settingButton
        ] .forEach { scrollView.addSubview($0) }

        [ label,
          totalSaveMoney] .forEach { subView.addSubview($0) }
        
        view.backgroundColor = .white
        calendar.backgroundColor = .white
                
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY. M"
        calendar.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)
        calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendar.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendar.weekdayHeight = 20
        calendar.appearance.borderSelectionColor = .red
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.titleWeekendColor = .red
        calendar.appearance.selectionColor = .systemPink
        calendar.appearance.eventDefaultColor = .systemPink
        calendar.appearance.weekdayTextColor = .lightGray
        calendar.appearance.todayColor = .systemGray4
        calendar.appearance.calendar.sizeToFit()
        calendar.appearance.subtitleOffset = CGPoint(x: 0, y: 10)
        calendar.placeholderType = .none
        calendar.appearance.subtitleSelectionColor = .systemPink
        calendar.appearance.subtitleTodayColor = .darkGray
    
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.height.equalTo(view)
        }
        
        monthButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        weekendButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(monthButton.snp.trailing).offset(10)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(monthButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        todayBtn.snp.makeConstraints {
            $0.centerY.equalTo(calendar.calendarHeaderView.snp.centerY)
            $0.leading.equalToSuperview().inset(10)
        }
        
        subView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(subView).inset(20)
        }
        
        totalSaveMoney.snp.makeConstraints {
            $0.top.equalTo(label)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        addBtn.snp.makeConstraints {
            $0.centerY.equalTo(calendar.calendarHeaderView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
            $0.width.equalTo(scrollView)
        }
    }
    
    func setDayData(_ date: Date) {
        viewModel.date = date
        label.text = viewModel.selectedDay(date)
        
        viewModel.saveOfSelectedDay(date: getStringToDate(date: date))
        totalSaveMoney.text = "절약한 돈: " + viewModel.calTodaySaveMoney()
        collectionView.reloadData()
    }
    
    @objc func addBtnClicked() {
        let InputVC = InputViewController()
        viewModel.setSelectedDate()
        InputVC.label.text = getMonthAndDayForString(date: viewModel.date!)
        
        self.navigationController?.pushViewController(InputVC, animated: true)
    }
}
