//
//  ViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//

import UIKit
import Charts

class HomeViewController: UIViewController {

    let barChartView: BarChartView = {
        let chartView = BarChartView()

        return chartView
    }()
    
    let subView: UIView = {
        let view = UIView()
        
        view.layer.shadowColor = UIColor.systemGray.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.4
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    let weekendLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "이번 주 절약 내역"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        configureUI()
        configureChartView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureChartView()
    }
    
    func configureUI() {

        view.addSubview(subView)
        
        [barChartView, weekendLabel] .forEach { subView.addSubview($0) }
        
        subView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(300)
        }
        
        barChartView.snp.makeConstraints {
            $0.top.equalTo(weekendLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        weekendLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
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
