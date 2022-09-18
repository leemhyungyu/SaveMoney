//
//  DetailLabelView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/09/11.
//

import UIKit
import SnapKit

class DetailLabelView: UIView {
    
    // MARK: - Properties

    var titleLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray2
        
        return label
    }()
    
    var contentLabel: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 18)
        
        return label
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

extension DetailLabelView {
    func configureUI() {
        
        [titleLabel, contentLabel] .forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
    }
    
    func setLabelView(title: String, content: String) {
        self.titleLabel.text = title
        self.contentLabel.text = content
    }
}
