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
    
    var subView: UIView = {
        let view = UIView()
        
        view.setShadow()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    var infoLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "최고 절약 정보"
        
        return label
    }()
    
    var moneyLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    var planNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        
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
        
        [infoLabel, moneyLabel, categoryLabel, arrowLabel, planNameLabel, finalNameLabel] .forEach { subView.addSubview($0) }
        
        
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)        }
        
        planNameLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)        }
        
        arrowLabel.snp.makeConstraints {
            $0.top.equalTo(planNameLabel)
            $0.leading.equalTo(planNameLabel.snp.trailing).offset(10)
        }
        
        finalNameLabel.snp.makeConstraints {
            $0.top.equalTo(planNameLabel)
            $0.leading.equalTo(arrowLabel.snp.trailing).offset(10)
        }
        
        moneyLabel.snp.makeConstraints {
            $0.top.equalTo(planNameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
    }
    
    func upDateUI(save: Save) {
        categoryLabel.text = save.category
        planNameLabel.text = save.planName
        finalNameLabel.text = save.finalName
        moneyLabel.text = setStringForWon(save.saveMoney)
    }
}
