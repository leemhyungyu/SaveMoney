//
//  MainCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//
import UIKit
import SnapKit

class MainCell: UICollectionViewCell {
 
    static let identifier = "MainCell"
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        
        addSubview(subView)
        
        [ categoryimage ,planNameLabel, finalNameLabel, arrowLabel, saveMoneyLabel] .forEach { subView.addSubview($0) }
        
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
    }
    
    func updateUI(save: Save) {
        categoryimage.image = setCategoryImage(title: save.category)
        planNameLabel.text = save.planName
        finalNameLabel.text = save.finalName
        saveMoneyLabel.text = setStringForWon(save.saveMoney)
    }
    
    func setCategoryImage(title: String) -> UIImage {
        if title == "교통" {
            return UIImage(systemName: "car.fill")!
        } else if title == "음식" {
            return UIImage(systemName: "fork.knife")!
        } else if title == "취미" {
            return UIImage(systemName: "gamecontroller.fill")!
        } else if title == "커피" {
            return UIImage(systemName: "cup.and.saucer.fill")!
        } else if title == "생활" {
            return UIImage(systemName: "figure.walk")!
        } else if title == "기타" {
            return UIImage(systemName: "wrench.and.screwdriver.fill")!
        } else {
            return UIImage()
        }
    }
}
