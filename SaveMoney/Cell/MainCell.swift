//
//  MainCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//
import UIKit
import SnapKit

class MainCell: UICollectionViewCell {

    // MARK: - Identifier
    
    static let identifier = "MainCell"

    // MARK: - Properties
    
    var cancleButtonClosure: (() -> Void)?
    
    var subView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    var categoryimage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.tintColor = .systemPink
        return imageView
    }()
    
    var planNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
 
        return label
    }()
    
    var finalNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
 
        return label
    }()
    
    var saveMoneyLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
 
        return label
    }()
    
    var arrowLabel: UILabel = {
        let label = UILabel()
        
        label.text = "→"
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var cancleBtn: UIButton = {
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "multiply")
        
        let btn = UIButton(configuration: config)
        btn.tintColor = .systemPink
        
        btn.addTarget(self, action: #selector(cancleBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func cancleBtnClicked() {
        if let cancleButtonClosure = cancleButtonClosure {
            cancleButtonClosure()
        }
    }
}

// MARK: - Functions

extension MainCell {
    func setUp() {
        
        addSubview(subView)
        
        [ categoryimage ,planNameLabel, finalNameLabel, arrowLabel, saveMoneyLabel, cancleBtn] .forEach { subView.addSubview($0) }
        
        subView.layer.shadowColor = UIColor.systemGray.cgColor
        subView.layer.masksToBounds = false
        subView.layer.shadowRadius = 7
        subView.layer.shadowOpacity = 0.4
        subView.layer.cornerRadius = 8
        subView.backgroundColor = .white
        
        subView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            
        }
        
        categoryimage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        planNameLabel.snp.makeConstraints {
            $0.top.equalTo(categoryimage.snp.bottom).offset(10)
            $0.leading.equalTo(categoryimage)
        }
        
        arrowLabel.snp.makeConstraints {
            $0.top.equalTo(planNameLabel)
            $0.leading.equalTo(planNameLabel.snp.trailing).offset(10)
        }
        
        finalNameLabel.snp.makeConstraints {
            $0.top.equalTo(planNameLabel)
            $0.leading.equalTo(arrowLabel.snp.trailing).offset(10)
        }
        
        saveMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(planNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(categoryimage)
        }
        
        cancleBtn.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
    }
    
    func updateUI(save: Save) {
        
        if save.category == "저축" {
            arrowLabel.isHidden = true
            finalNameLabel.isHidden = true

        } else {
            finalNameLabel.text = save.finalName
        }
        
        planNameLabel.text = save.planName
        categoryimage.image = setCategoryImage(save)
        saveMoneyLabel.text = setStringForWon(save.saveMoney)
    }
}
