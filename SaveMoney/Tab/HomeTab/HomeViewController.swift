//
//  ViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//

import UIKit
import Charts
import ExpyTableView

class HomeViewController: UIViewController {

    let viewModel = HomeViewModel()
    private var tableViewHeightConstraint: NSLayoutConstraint!

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
    
    let tableView: ExpyTableView = {
        let tableView = ExpyTableView(frame: .zero)
        
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)
        tableView.register(MaxSaveCell.self, forCellReuseIdentifier: MaxSaveCell.identifier)
        
        tableView.isScrollEnabled = false
        return tableView
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
        tableView.reloadData()
        configureChartView()
    }
    
//    override func viewWillLayoutSubviews() {
//        tableView.ex
//    }
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.invalidateIntrinsicContentSize()
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 120)
        tableViewHeightConstraint.isActive = true
        scrollView.addSubview(mainView)
        
        [subView, dayButton, weekButton, monthButton, tableView] .forEach { mainView.addSubview($0) }

        [dayBarChartView, weekBarChartView, monthBarChartView] .forEach { subView.addSubview($0) }
                
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(view)
        }
        
        mainView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView)
            $0.height.equalTo(930)
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
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
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
}

extension HomeViewController: ExpyTableViewDelegate, ExpyTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MaxSaveCell.identifier, for: indexPath) as? MaxSaveCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            if cell.moneyLabel.text == "0원" {
                return UITableViewCell()
            } else {
                guard let save = viewModel.maxTotalSave else {
                    cell.setUI(true)
                    return cell
                }
                cell.upDateUI(save: viewModel.maxTotalSave!)
            }
        case 1:
            guard let save = viewModel.maxThisMonthSave else {
                cell.setUI(true)
                return cell
            }
            cell.upDateUI(save: viewModel.maxThisMonthSave!)
        case 2:
            guard let save = viewModel.maxThisWeekendSave else {
                cell.setUI(true)
                return cell
            }
            
            cell.upDateUI(save: viewModel.maxThisWeekendSave!)
        default:
            break
        }
        
        cell.selectionStyle = .none
        cell.setUI(false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 40
        default:
            return 130
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            tableView.reloadData()
            
            if viewModel.bool[indexPath.section] == false {
                viewModel.bool[indexPath.section] = true
                tableViewHeightConstraint.constant += 130

            } else {
                viewModel.bool[indexPath.section] = false
                tableViewHeightConstraint.constant -= 130
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numOfCell
    }
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        true
    }
    
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {

        switch state {
        case .willExpand:
        
         print("WILL EXPAND")
        case .willCollapse:

         print("WILL COLLAPSE")

        case .didExpand:

         print("DID EXPAND")

        case .didCollapse:

         print("DID COLLAPSE")
        }
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier) as? HomeCell else { return UITableViewCell() }
        
        cell.titleLabel.text = viewModel.titleOfCell(index: section)
        cell.moneyLabel.text = viewModel.moneyOfCell(index: section)

        cell.cellClicked(bool: viewModel.bool[section])
        return cell
    }
}
class YAxisValueFormatter: ValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        
        let result = setIntForWon(Int(value))
        
        return String(result)
    }
}
