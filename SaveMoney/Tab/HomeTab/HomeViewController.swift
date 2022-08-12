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
    
    let barChartView: BarChartView = {
        let chartView = BarChartView()

        return chartView
    }()
    
    let subView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setShadow()
        return view
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.retrieve()
        viewModel.setWeekendDate()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.setWeekendData()
        viewModel.setMoneyData()
        configureChartView()
        totalLabel.text = "총 \(viewModel.totalMoney!)을 세이브 하셨습니다.\n최고 저축액은 \(viewModel.maxSaveMoney!)입니다."
        monthLabel.text = "이번 달은 20,000원을 세이브 하셨습니다."
        weekendLabel.text = "이번 주는 \(viewModel.weekendMoney!)을 세이브 하셨습니다."
    }
    
    func configureUI() {
        
        
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        view.addSubview(scrollView)
        
        scrollView.addSubview(mainView)
        
        [subView, totalView, monthView, weekendView] .forEach { mainView.addSubview($0) }

        
        [totalHeaderView, totalLabel] .forEach { totalView.addSubview($0) }
        
        [monthHeaderView, monthLabel] .forEach { monthView.addSubview($0) }
        
        [weekendHeaderView, weekendLabel] .forEach { weekendView.addSubview($0) }
        
        [barChartView, grpahHeaderView] .forEach { subView.addSubview($0) }
        
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
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(300)
        }

        grpahHeaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(subView.snp.top).offset(25)
        }

        barChartView.snp.makeConstraints {
            $0.top.equalTo(grpahHeaderView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
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
                
        setChart(dataPoints: viewModel.day, values: viewModel.weekendData)
        
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 16)
        barChartView.noDataTextColor = .lightGray
        
        barChartView.backgroundColor = .white
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelFont = .systemFont(ofSize: 16)
        barChartView.xAxis.axisLineColor = .black
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: viewModel.day)
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.enabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.legend.enabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
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
        barChartView.data = chartData
        barChartView.data?.setValueFormatter(YAxisValueFormatter())
    }
}

class YAxisValueFormatter: ValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        
        let result = setIntForWon(Int(value))
        
        return String(result)
    }
}
