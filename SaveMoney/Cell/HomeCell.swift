//
//  HomeCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/17.
//

import UIKit
import SnapKit

class HomeCell: UITableViewCell {
    
    static let identifier = "HomeCell"
    
    var titleLabel: UILabel = {
        var label =  UILabel()
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    var moneyLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        
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
        [titleLabel, moneyLabel] .forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        moneyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
