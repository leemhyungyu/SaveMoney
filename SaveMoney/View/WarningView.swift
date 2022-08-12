//
//  WarningView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/12.
//

import UIKit
import SnapKit

class WarningView: UIView {
        
    var subView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    var warningLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        
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
        addSubview(subView)
        subView.addSubview(warningLabel)

        subView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }

        warningLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
