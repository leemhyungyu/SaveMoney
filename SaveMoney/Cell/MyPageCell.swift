//
//  MypageCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/12.
//

import UIKit
import SnapKit

class MyPageCell: UITableViewCell {
    
    static let identifier = "MyPageCell"
    
    var label: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.text = "테스트"
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
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
    }
}
