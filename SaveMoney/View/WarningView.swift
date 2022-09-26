//
//  WarningView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/12.
//

import UIKit
import SnapKit

class WarningView: UIView {
    
    // MARK: - Properties

    var warningLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        
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

extension WarningView {
    func configureUI() {
        
        backgroundColor = .systemGray
        layer.cornerRadius = 25
        
        addSubview(warningLabel)


        warningLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
