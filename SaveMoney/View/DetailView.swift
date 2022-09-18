//
//  DetailView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/09/10.
//

import UIKit
import SnapKit

class DetailView: UIView {
    
    // MARK: - Properties

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
        
    lazy var deleteButton: UIButton = {
        var configure = UIButton.Configuration.plain()
        configure.image = UIImage(systemName: "multiply")
        
        let button = UIButton(configuration: configure)
        button.tintColor = .systemPink
                
        return button
    }()
    
    lazy var changeButton: UIButton = {
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
    
    var imaginNameLabelView: DetailLabelView = {
        var view = DetailLabelView()
        
        return view
    }()
    
    var imaginMoneyLabelVIew: DetailLabelView = {
        var view = DetailLabelView()
        
        return view
    }()
    
    var realNameLabelView: DetailLabelView = {
        var view = DetailLabelView()
        
        return view
    }()
    
    var realMoneyLabelView: DetailLabelView = {
        var view = DetailLabelView()
        
        return view
    }()
    
    var SaveMoneyLabelView: DetailLabelView = {
        var view = DetailLabelView()
        
        return view
    }()
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Functions

extension DetailView {
    
    func configureUI() {
        
        backgroundColor = .white

        [categoryImage, categoryLabel, deleteButton, changeButton, dayLabel, imaginNameLabelView, imaginMoneyLabelVIew, realNameLabelView, realMoneyLabelView, SaveMoneyLabelView] .forEach { addSubview($0) }
        
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

        imaginNameLabelView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(20)
        }
        
        imaginMoneyLabelVIew.snp.makeConstraints {
            $0.top.equalTo(imaginNameLabelView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(20)
        }
        
        realNameLabelView.snp.makeConstraints {
            $0.top.equalTo(imaginMoneyLabelVIew.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(20)
        }
        
        realMoneyLabelView.snp.makeConstraints {
            $0.top.equalTo(realNameLabelView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(20)
        }
        
        SaveMoneyLabelView.snp.makeConstraints {
            $0.top.equalTo(realMoneyLabelView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(20)
        }
    }
    
    func setView(save: Save) {
        
        dayLabel.text = save.day
        categoryImage.image = setCategoryImage(save)
        categoryLabel.text = save.category

        imaginNameLabelView.setLabelView(title: "상상 구매 물품", content: save.planName)
        imaginMoneyLabelVIew.setLabelView(title: "상상 구매 가격", content: setStringForWon(save.planMoney))
        realNameLabelView.setLabelView(title: "실제 구매 물품", content: save.finalName)
        realMoneyLabelView.setLabelView(title: "실제 구매 가격", content: setStringForWon(save.finalMoney))
        SaveMoneyLabelView.setLabelView(title: "절약한 금액", content: setStringForWon(save.saveMoney))
        
    }
}
