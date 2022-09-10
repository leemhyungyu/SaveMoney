//
//  DetailView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/09/10.
//

import UIKit
import SnapKit

class DetailView: UIView {
    

    var categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemPink

        return imageView
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        return label
    }()
        
    var deleteButton: UIButton = {
        var configure = UIButton.Configuration.plain()
        configure.image = UIImage(systemName: "multiply")
        
        let button = UIButton(configuration: configure)
        button.tintColor = .systemPink
        
        return button
    }()
    
    var changeButton: UIButton = {
        var configure = UIButton.Configuration.plain()
        configure.image = UIImage(systemName: "pencil")
        
        let button = UIButton(configuration: configure)
        button.tintColor = .systemPink
        
        return button
    }()
    
    var dayLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray2
        
        return label
    }()
    
    var realNameTitleLabel: UILabel = {
        var label = UILabel()
        
        label.text = "실제 구매 물품"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray2

        return label
    }()
    
    var realNameLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    var imaginNameTitleLabel: UILabel = {
        var label = UILabel()
        
        label.text = "상상 구매 물품"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray2
        
        return label
    }()
    
    var imaginNameLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    var imaginMoneyTitleLabel: UILabel = {
        var label = UILabel()
        
        label.text = "상상 구매 가격"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray2
        
        return label
    }()
    
    var imaginMoneyLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    var realMoneyTitleLabel: UILabel = {
        var label = UILabel()
        
        label.text = "실제 구매 가격"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray2
        
        return label
    }()
    
    var realMoneyLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    var saveTitleLabel: UILabel = {
        var label = UILabel()
        
        label.text = "절약한 금액"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray2
        
        return label
    }()
    
    var saveMoneyLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        backgroundColor = .white
        
        [categoryImage, categoryLabel, deleteButton, changeButton, dayLabel, imaginNameTitleLabel, imaginNameLabel, realNameTitleLabel, realNameLabel, imaginMoneyTitleLabel, imaginMoneyLabel, realMoneyTitleLabel, realMoneyLabel, saveTitleLabel, saveMoneyLabel] .forEach { addSubview($0) }
        
        categoryImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
            $0.width.height.equalTo(25)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(categoryImage.snp.bottom)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(15)
        }
        
        changeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-8)
            $0.width.height.equalTo(15)
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(deleteButton)
            $0.leading.equalToSuperview().inset(10)
        }
        
        imaginNameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(10)
        }
        
        imaginNameLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(30)
            $0.leading.equalTo(imaginNameTitleLabel.snp.trailing).offset(20)
        }
        
        imaginMoneyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(imaginNameTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        imaginMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(imaginNameTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(realNameTitleLabel.snp.trailing).offset(20)
        }
        
        realNameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(imaginMoneyTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        realNameLabel.snp.makeConstraints {
            $0.top.equalTo(imaginMoneyTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(realNameTitleLabel.snp.trailing).offset(20)
        }
        
        realMoneyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(realNameTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        realMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(realNameTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(realMoneyTitleLabel.snp.trailing).offset(20)
        }
        
        saveTitleLabel.snp.makeConstraints {
            $0.top.equalTo(realMoneyTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        saveMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(realMoneyTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(realMoneyLabel)
        }
    }
    
    func setView(save: Save) {
        
        dayLabel.text = save.day
        categoryImage.image = setCategoryImage(save)
        categoryLabel.text = save.category
        imaginNameLabel.text = save.planName
        imaginMoneyLabel.text = setStringForWon(save.planMoney)
        realMoneyLabel.text = setStringForWon(save.finalMoney)
        saveMoneyLabel.text = setStringForWon(save.saveMoney)
        realNameLabel.text = save.finalName
    }
}
