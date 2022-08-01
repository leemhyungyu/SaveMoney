//
//  ViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//

import UIKit
import Charts

class HomeViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    let mainView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let barChartView: BarChartView = {
        let chartView = BarChartView()

        return chartView
    }()
    
    let subView: UIView = {
        let view = UIView()
        
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

        view.backgroundColor = .white
        return view
    }()
    
    let weekendHeaderView: UIView = {
        let view = HomeSubHeaderView(title: "이번 주 저축 금액")
        
        return view
    }()
    
    
    let weekendView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let totalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        configureChartView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureChartView()
    }
    
    func configureUI() {

        view.addSubview(scrollView)
        
        scrollView.addSubview(mainView)
        
        [subView, totalView, monthView, weekendView, totalHeaderView, monthHeaderView, weekendHeaderView] .forEach { mainView.addSubview($0) }

        [barChartView, grpahHeaderView] .forEach { subView.addSubview($0) }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.height.equalTo(view)
        }
        
        mainView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView)
            $0.height.equalTo(850)
        }
        
        subView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(300)
        }

        grpahHeaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(subView.snp.top).offset(30)
        }

        barChartView.snp.makeConstraints {
            $0.top.equalTo(grpahHeaderView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }

        totalHeaderView.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        totalView.snp.makeConstraints {
            $0.top.equalTo(totalHeaderView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(100)
        }
        
        monthHeaderView.snp.makeConstraints {
            $0.top.equalTo(totalView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        monthView.snp.makeConstraints {
            $0.top.equalTo(monthHeaderView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(100)
        }
        
        weekendHeaderView.snp.makeConstraints {
            $0.top.equalTo(monthView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        weekendView.snp.makeConstraints {
            $0.top.equalTo(weekendHeaderView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(100)
        }
    }
    
    func configureChartView() {
        
        // UI테스트를 위한 임시 데이터
        let dummyDateData = ["월", "화", "수", "목", "금", "토", "일"]
        let dummyMoneyData: [Double] = [2000, 5000, 14000, 4100, 23100, 10000, 4000]
        
        setChart(dataPoints: dummyDateData, values: dummyMoneyData)
        
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 16)
        barChartView.noDataTextColor = .lightGray
        
        barChartView.backgroundColor = .white
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelFont = .systemFont(ofSize: 16)
        barChartView.xAxis.axisLineColor = .black
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dummyDateData)
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
