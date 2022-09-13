//
//  MypageCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/12.
//

import UIKit
import SnapKit

class SettingCell: UITableViewCell {
    
    static let identifier = "SettingCell"
    
    var label: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    var separatorView: UIView = {
        var view = UIView()
        
        view.backgroundColor = .darkGray
        
        return view
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
        addSubview(separatorView)
        self.backgroundColor = .clear
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1.5)
        }
    }
}
