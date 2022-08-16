//
//  ViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//

import UIKit
import Charts

class HomeViewController: UIViewController {

    let viewModel = HomeViewModel()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let mainView: UIView = {
        let view = UIView()
        
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        return view
    }()
    
    let subView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setShadow()
        return view
    }()
            
    let dayBarChartView: CustomBarChartView = {
        let barChartView = CustomBarChartView()
        
        barChartView.xAxis.labelCount = 7
        barChartView.isHidden = false
        return barChartView
    }()
    
    let weekBarChartView: CustomBarChartView = {
        let barChartView = CustomBarChartView()
        barChartView.xAxis.labelCount = 12
        barChartView.isHidden = true
        return barChartView
    }()
    
    var monthBarChartView: CustomBarChartView = {
        let barCharView = CustomBarChartView()
        
        barCharView.isHidden = true
        return barCharView
    }()
    
    let grpahHeaderView: UIView = {
        let view = HomeHeaderView(title: "이번 주 그래프")
        
        return view
    }()

    let totalHeaderView: UIView = {
        let view = HomeSubHeaderView(title: "총 저축 금액")
        
        return view
    }()
    
    let monthHeaderView: UIView = {
        let view = HomeSubHeaderView(title: "이번 달 저축 금액")
        
        return view
    }()
    
    let monthView: UIView = {
        let view = UIView()

        view.setShadow()
        view.backgroundColor = .white
        return view
    }()
    
    let weekendHeaderView: UIView = {
        let view = HomeSubHeaderView(title: "이번 주 저축 금액")
        
        return view
    }()
    
    
    let weekendView: UIView = {
        let view = UIView()
        view.setShadow()
        view.backgroundColor = .white
        return view
    }()
    
    let totalView: UIView = {
        let view = UIView()
        view.setShadow()
        view.backgroundColor = .white
        return view
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    let weekendLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var monthButton: UIButton = {
        let button = UIButton()
        
        button.setButtonShape(title: "월간")
        button.addTarget(self, action: #selector(monthButtonClicked), for: .touchUpInside)
        button.isSelected = false

        return button
    }()

    lazy var weekButton: UIButton = {
        let button = UIButton()
        
        button.setButtonShape(title: "주간")
        button.addTarget(self, action: #selector(weekButtonClicked), for: .touchUpInside)
        
        button.isSelected = false
        return button
    }()

    lazy var dayButton: UIButton = {
        let button = UIButton()
        
        button.setButtonShape(title: "일간")
        button.addTarget(self, action: #selector(dayButtonClicked), for: .touchUpInside)
        
        button.isSelected = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.retrieve()
        viewModel.setMonthData()
        viewModel.setEachDayDate()
        viewModel.setWeekendDayDate()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.retrieve()
        viewModel.setMoneyData()
        viewModel.setEachDayDate()
        viewModel.setWeekendDayDate()

        configureChartView()
        
        totalLabel.text = "총 \(viewModel.totalMoney!)을 세이브 하셨습니다.\n최고 저축액은 \(viewModel.maxSaveMoney!)입니다."
        monthLabel.text = "이번 달은 \(viewModel.thisMonthMoney!)을 세이브 하셨습니다.\n이번 달 최고 저축 금액은 50,000원입니다."
//        weekendLabel.text = "이번 주는 \(viewModel.weekendMoney!)을 세이브 하셨습니다.\n이번 주 최고 저축 금액은 50,000원입니다."
    }
    
    
    @objc func dayButtonClicked() {
        
        if dayButton.isSelected == true {
            dayBarChartView.isHidden = !dayButton.isSelected
            
            weekBarChartView.isHidden = dayButton.isSelected
            monthBarChartView.isHidden = dayButton.isSelected
            
            weekButton.isSelected = !dayButton.isSelected
            monthButton.isSelected = !dayButton.isSelected
        } else {
            dayBarChartView.isHidden = dayButton.isSelected
            dayButton.isSelected = !dayButton.isSelected
            
            weekBarChartView.isHidden = dayButton.isSelected
            monthBarChartView.isHidden = dayButton.isSelected
            
            weekButton.isSelected = !dayButton.isSelected
            monthButton.isSelected = !dayButton.isSelected
        }
    }
     
    @objc func weekButtonClicked() {
        
        if weekButton.isSelected == true {
            weekBarChartView.isHidden = !weekButton.isSelected
            
            dayBarChartView.isHidden = weekButton.isSelected
            monthBarChartView.isHidden = weekButton.isSelected
            
            dayButton.isSelected = !weekButton.isSelected
            monthButton.isSelected = !weekButton.isSelected
        } else {
            weekBarChartView.isHidden = weekButton.isSelected
            weekButton.isSelected = !weekButton.isSelected
            
            dayBarChartView.isHidden = weekButton.isSelected
            monthBarChartView.isHidden = weekButton.isSelected
            
            dayButton.isSelected = !weekButton.isSelected
            monthButton.isSelected = !weekButton.isSelected
        }
    }
    
    @objc func monthButtonClicked() {
        
        if monthButton.isSelected == true {
            monthBarChartView.isHidden = !monthButton.isSelected
            
            dayBarChartView.isHidden = monthButton.isSelected
            weekBarChartView.isHidden = monthButton.isSelected
            
            dayButton.isSelected = !monthButton.isSelected
            weekButton.isSelected = !monthButton.isSelected
        } else {
            monthBarChartView.isHidden = monthButton.isSelected
            monthButton.isSelected = !monthButton.isSelected
            
            dayBarChartView.isHidden = monthButton.isSelected
            weekBarChartView.isHidden = monthButton.isSelected
            
            dayButton.isSelected = !monthButton.isSelected
            weekButton.isSelected = !monthButton.isSelected
        }
    }

    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        view.addSubview(scrollView)
        
        scrollView.addSubview(mainView)
        
        [subView, totalView, monthView, weekendView, dayButton, weekButton, monthButton] .forEach { mainView.addSubview($0) }

        
        [totalHeaderView, totalLabel] .forEach { totalView.addSubview($0) }
        
        [monthHeaderView, monthLabel] .forEach { monthView.addSubview($0) }
        
        [weekendHeaderView, weekendLabel] .forEach { weekendView.addSubview($0) }
        
        [dayBarChartView, weekBarChartView, monthBarChartView] .forEach { subView.addSubview($0) }
                
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(view)
        }
        
        mainView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView)
            $0.height.equalTo(900)
        }
        
        subView.snp.makeConstraints {
            $0.top.equalTo(weekButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        dayButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        weekButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(dayButton.snp.trailing).offset(5)
        }
        
        monthButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(weekButton.snp.trailing).offset(5)
        }

        dayBarChartView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(10)
        }

        weekBarChartView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        monthBarChartView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        totalHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }

        totalView.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(100)
        }
        
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(totalHeaderView.snp.bottom).offset(10)
            $0.leading.equalTo(totalHeaderView)
        }
        
        monthHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        monthView.snp.makeConstraints {
            $0.top.equalTo(totalView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(100)
        }
        
        monthLabel.snp.makeConstraints {
            $0.top.equalTo(monthHeaderView.snp.bottom).offset(10)
            $0.leading.equalTo(monthHeaderView)
        }
        
        weekendHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        weekendView.snp.makeConstraints {
            $0.top.equalTo(monthView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(100)
        }
        
        weekendLabel.snp.makeConstraints {
            $0.top.equalTo(weekendHeaderView.snp.bottom).offset(10)
            $0.leading.equalTo(weekendHeaderView)
        }
    }
    
    func configureChartView() {
        
        dayBarChartView.setChart(dataPoints: viewModel.EachDayDate, values: viewModel.EachDayMoney)
        
        weekBarChartView.setChart(dataPoints: viewModel.EachWeekendDate, values: viewModel.EachWeekendMoney)
        
        monthBarChartView.setChart(dataPoints: viewModel.month, values: viewModel.monthMoney)
    }
    
    func setChart(barchartView: BarChartView, dataPoints: [String], values: [Double]) {

        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries)

        chartDataSet.colors = [.systemPink]
        chartDataSet.valueFont = .systemFont(ofSize: 12)
        chartDataSet.highlightEnabled = false

        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.3
        barchartView.data = chartData
        barchartView.data?.setValueFormatter(YAxisValueFormatter())
    }
//
//    func configureChartView() {
//
//        setChart(dataPoints: viewModel.day, values: viewModel.weekendData)
//    }
//
//    func setChart(dataPoints: [String], values: [Double]) {
//
//        var dataEntries: [BarChartDataEntry] = []
//
//        for i in 0..<dataPoints.count {
//            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
//            dataEntries.append(dataEntry)
//        }
//
//        let chartDataSet = BarChartDataSet(entries: dataEntries)
//
//        chartDataSet.colors = [.systemPink]
//        chartDataSet.valueFont = .systemFont(ofSize: 12)
//        chartDataSet.highlightEnabled = false
//
//        let chartData = BarChartData(dataSet: chartDataSet)
//        chartData.barWidth = 0.3
//        barChartView.data = chartData
//        barChartView.data?.setValueFormatter(YAxisValueFormatter())
//    }
}

class YAxisValueFormatter: ValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        
        let result = setIntForWon(Int(value))
        
        return String(result)
    }
}
