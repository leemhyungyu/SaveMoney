//
//  SaveCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/26.
//

import UIKit
import SnapKit

class SaveCell: UITableViewCell {
    
    // MARK: - Identifier

    static let identifier = "SaveCell"
    
    // MARK: - Properties

    var planName: UILabel = {
        let label = UILabel()
        
        label.text = ""
        
        return label
    }()
    
    var finalName: UILabel = {
        let label = UILabel()
        
        label.text = ""
        
        return label
    }()
    
    var saveMoney: UILabel = {
        let label = UILabel()
        
        label.text = ""
        
        return label
    }()
    
    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

// MARK: - Functions

extension SaveCell {
    
    func setting() {
        addSubview(planName)
        addSubview(finalName)
        addSubview(saveMoney)
        
        planName.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        finalName.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(planName.snp.trailing).offset(10)
        }
        
        saveMoney.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(finalName.snp.trailing).offset(10)
        }
    }
    
    func updateCell(save: Save) {
        
        self.planName.text = save.planName
        self.planName.text?.append("대신")
        self.finalName.text = save.finalName
        self.finalName.text?.append("을 구매해서")
        self.saveMoney.text = save.saveMoney
        self.saveMoney.text?.append("원을 아겼습니다.")
    }
}
