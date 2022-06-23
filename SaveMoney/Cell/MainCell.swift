//
//  MainCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//
import UIKit
import SnapKit

class MainCell: UITableViewCell {
 
    static let identifier = "MainCell"
    
    var label: UILabel = {
        let label = UILabel()
        
        label.text = "테스트입니다."
        label.font = .systemFont(ofSize: 50)
//        label.textColor = .blue
        
        return label
    }()
    
    
    override func layoutSubviews() {
        setUp()
        
    }
    
    func setUp() {
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func updateUI(Date: String) {
        label.text = Date
    }
}
