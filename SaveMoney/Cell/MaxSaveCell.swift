//
//  MaxSaveCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/18.
//

import UIKit
import SnapKit

class MaxSaveCell: UITableViewCell {
    static let identifier = "MaxSaveCell"
    
    var noDataView: UIView = {
        let view = UIView()
        
        view.setShadow()
        
        view.backgroundColor = .white
        
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
    
    var moneyLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.text = "금액: "
        return label
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.text = "카테고리: "
        return label
    }()
    
    var planNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.text = "물품: "
        return label
    }()
    
    var arrowLabel: UILabel = {
        let label = UILabel()
        
        label.text = "→"
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    var finalNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        addSubview(subView)
        addSubview(noDataView)
        
        backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        [infoLabel, moneyLabel, categoryLabel, arrowLabel, planNameLabel, finalNameLabel] .forEach { subView.addSubview($0) }
        
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
        
        moneyLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
        }
    
        planNameLabel.snp.makeConstraints {
            $0.top.equalTo(moneyLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
        }
        
        arrowLabel.snp.makeConstraints {
            $0.centerY.equalTo(planNameLabel)
            $0.leading.equalTo(planNameLabel.snp.trailing).offset(5)
        }
        
        finalNameLabel.snp.makeConstraints {
            $0.top.equalTo(planNameLabel)
            $0.leading.equalTo(arrowLabel.snp.trailing).offset(5)
        }
    }
    
    func upDateUI(save: Save) {
        infoLabel.text = "최고 절약 정보 " + "(" + save.day + ")"
        categoryLabel.text = "카테고리: " + save.category
        planNameLabel.text = "물품: " + save.planName
        finalNameLabel.text = save.finalName
        moneyLabel.text = "금액: " + setStringForWon(save.saveMoney)
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

