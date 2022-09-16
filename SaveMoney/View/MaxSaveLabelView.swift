//
//  MaxSaveLabelView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/09/16.
//

import UIKit
import SnapKit

class MaxSaveLabelView: UIView {
    
    var titleLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        
        return label
    }()
    
    var contentLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        
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
        [titleLabel, contentLabel] .forEach { addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
        }
    }
    
    func setLabelView(title: String, content: String) {
        self.titleLabel.text = title
        self.contentLabel.text = content
    }
}
