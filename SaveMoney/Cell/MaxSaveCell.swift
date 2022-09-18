//
//  MaxSaveCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/18.
//

import UIKit
import SnapKit

class MaxSaveCell: UITableViewCell {
    
    // MARK: - Identifier

    static let identifier = "MaxSaveCell"
    
    // MARK: - Properties

    var noDataView: UIView = {
        let view = UIView()
        
        view.setShadow()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    var categoryLabelView: MaxSaveLabelView = {
        var view = MaxSaveLabelView()
        
        return view
    }()
    
    var moneyLabelView: MaxSaveLabelView = {
        var view = MaxSaveLabelView()
        
        return view
    }()
    
    var nameLabelView: MaxSaveLabelView = {
        var view = MaxSaveLabelView()
        
        return view
    }()
    
    var label: UILabel = {
        let label = UILabel()
        
        label.text = "아직 입력된 내용이 없습니다."
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    var subView: UIView = {
        let view = UIView()
        
        view.setShadow()
        
        view.backgroundColor = .white
        
        return view
    }()

    var infoLabel: UILabel = {

        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "최고 절약 정보"

        return label
    }()
    
    var dayLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Functions

extension MaxSaveCell {
    
    func configureUI() {
        
        addSubview(subView)
        addSubview(noDataView)
        
        backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        [categoryLabelView, moneyLabelView, nameLabelView, infoLabel, dayLabel] .forEach { subView.addSubview($0) }
        
        noDataView.addSubview(label)
        
        noDataView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
        }
        
        categoryLabelView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(18)
        }
        
        moneyLabelView.snp.makeConstraints {
            $0.top.equalTo(categoryLabelView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(18)
        }
        
        nameLabelView.snp.makeConstraints {
            $0.top.equalTo(moneyLabelView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(18)
        }
    }
    
    func upDateUI(save: Save) {
        let nameContentLabel = save.planName + " → " + save.finalName

        dayLabel.text = save.day
        categoryLabelView.setLabelView(title: "카테고리", content: save.category)
        moneyLabelView.setLabelView(title: "금액", content: setStringForWon(save.saveMoney))
        nameLabelView.setLabelView(title: "물품", content: nameContentLabel)
    }
    
    func setUI(_ bool: Bool) {
        if bool == true {
            subView.isHidden = true
            noDataView.isHidden = false
        } else {
            subView.isHidden = false
            noDataView.isHidden = true
        }
    }
}
