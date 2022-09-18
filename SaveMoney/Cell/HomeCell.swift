//
//  HomeCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/17.
//

import UIKit
import SnapKit

class HomeCell: UITableViewCell {
    
    // MARK: - Identifier

    static let identifier = "HomeCell"
    
    // MARK: - Properties

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
    
    
    var arrowDownImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "arrowDown")
        
        imageView.isHidden = true
        return imageView
    }()
    
    var arrowUpImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "arrowUp")
        
        imageView.isHidden = false
        return imageView
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

extension HomeCell {
    
    func configureUI() {
        [titleLabel, moneyLabel, arrowUpImage, arrowDownImage] .forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        moneyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
        }
        
        arrowUpImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(moneyLabel.snp.trailing).offset(10)
        }
        
        arrowDownImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(moneyLabel.snp.trailing).offset(10)
        }
    }
    
    func cellClicked(bool: Bool) {
        arrowUpImage.isHidden = bool
        arrowDownImage.isHidden = !bool
    }
}
