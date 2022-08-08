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
    private var calendarViewHegihtconstraint: NSLayoutConstraint!
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
    
    lazy var weekendButton: UIButton = {

        let btn = UIButton()
        
        btn.setImage(UIImage(named: "arrowDown"), for: .normal)
        btn.setImage(UIImage(named: "arrowUp"), for: .selected)
        
        btn.addTarget(self, action: #selector(weekendButtonClicked), for: .touchUpInside)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        viewModel.retrieve()
        setDayData(Date())
        setHeigthConstraint()
        viewModel.eventInCalendar()
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadMainData()
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
        
        let day = getStringToDate(date: Date())
        viewModel.saveOfSelectedDay(date: day)
        
        totalSaveMoney.text = "절약한 돈: " + viewModel.calTodaySaveMoney()
    }
    
    @objc func weekendButtonClicked() {
        
        weekendButton.isSelected = !weekendButton.isSelected
        
        if self.calendar.scope == .month {
            calendar.scope = .week
        } else {
            calendar.scope = .month
        }
    }
    
    func setHeigthConstraint() {
        collectionView.invalidateIntrinsicContentSize()
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 50)
        collectionViewHeightConstraint.isActive = true
        
        calendar.invalidateIntrinsicContentSize()
        calendarViewHegihtconstraint = calendar.heightAnchor.constraint(equalToConstant: 350)
        calendarViewHegihtconstraint.isActive = true
    }
    
    func initializationData() {
        viewModel.saveManager.saveStruct()
    }
    
    func reloadMainData() {
        collectionView.reloadData()
        calendar.reloadData()
        totalSaveMoney.text = "절약한 돈: " + viewModel.calTodaySaveMoney()
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
            calendarViewHegihtconstraint.constant = bounds.height + 30
        } else {
            calendarViewHegihtconstraint.constant = bounds.height
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
        
        calendar.addSubview(weekendButton)
        
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
        calendar.appearance.headerDateFormat = "YYYY. M"
//        calendar.appearance.headerTitleAlignment = .left
//        calendar.appearance.headerTitleOffset = CGPoint(x: -75, y: 0)
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
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(700)
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(scrollView)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        todayBtn.snp.makeConstraints {
            $0.centerY.equalTo(calendar.calendarHeaderView.snp.centerY)
            $0.trailing.equalTo(scrollView).offset(-20)
        }
        
        weekendButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(calendar.snp.bottom).offset(-25)
        }
        
        subView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview().inset(10)
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
    
    func setDayData(_ date: Date) {
        viewModel.date = date
        label.text = viewModel.selectedDay(date)
        
        viewModel.saveOfSelectedDay(date: getStringToDate(date: date))
        totalSaveMoney.text = "절약한 돈: " + viewModel.calTodaySaveMoney()
        collectionView.reloadData()
    }
    
    @objc func addBtnClicked(_ sender: UITapGestureRecognizer) {


        let InputVC = InputViewController()
        viewModel.inputViewModel.date = viewModel.date
        InputVC.label.text = getMonthAndDayForString(date: viewModel.date!)
        
        InputVC.modalPresentationStyle = .fullScreen
        present(InputVC, animated: true, completion: nil)
    }
}

extension CalendarViewController: SendDataDelegate {
    func sendData(data: Date) {
        calendar.select(data)
        label.text = viewModel.selectedDay(data)
    }
}
