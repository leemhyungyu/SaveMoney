//
//  AddCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/20.
//
import UIKit
import SnapKit

class AddCell: UITableViewCell {
 
    static let identifier = "addCell"

    var saveBtn: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.baseBackgroundColor = .blue
        config.image = UIImage(systemName: "plus.circle.fill")
        config.imagePadding = 10
        
        let btn = UIButton(configuration: config)
        
        return btn
    }()
    
    override func layoutSubviews() {
        setUp()
    }
    
    func setUp() {
        addSubview(saveBtn)
        
        saveBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

