//
//  BarChartView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/13.
//

import UIKit
import SnapKit
import Charts

class CustomBarChartView: BarChartView {

    let barChartView: BarChartView = {
        
        let charVIew = BarChartView()
        
        return charVIew
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        addSubview(barChartView)
        barChartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 16)
        barChartView.noDataTextColor = .lightGray
        
        barChartView.backgroundColor = .white
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelFont = .systemFont(ofSize: 16)
        barChartView.xAxis.axisLineColor = .black
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelCount = 12
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.enabled = false
        barChartView.doubleTapToZoomEnabled = true
        barChartView.legend.enabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.dragEnabled = false
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
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
    }
}
