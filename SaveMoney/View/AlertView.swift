//
//  AlertView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/04.
//

import UIKit
import SnapKit

final class AlertView: UIView {
        
    lazy var backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.4
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.systemGray
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    var separationLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor.systemPink
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 6
        button.setTitle("확인", for: .normal)
        button.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
               
        return button
    }()
    
    lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemPink
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 6
        button.setTitle("취소", for: .normal)
        button.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMinXMinYCorner)
            
        return button
    }()
    
    let recognizeTapBackground = UITapGestureRecognizer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [backgroundView, alertView]
            .forEach { addSubview($0) }
        
        [titleLabel, bodyLabel, doneButton, cancleButton, separationLine]
            .forEach { alertView.addSubview($0) }
        
        backgroundView.addGestureRecognizer(recognizeTapBackground)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bodyLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(doneButton.snp.bottom).inset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        cancleButton.snp.makeConstraints {
            $0.top.equalTo(bodyLabel.snp.bottom).offset(16)
            $0.leading.equalTo(alertView).offset(16)
            $0.height.equalTo(35)
            $0.trailing.equalTo(doneButton.snp.leading)
        }
        
        separationLine.snp.makeConstraints {
            $0.centerX.equalTo(alertView)
            $0.top.equalTo(cancleButton)
            $0.height.equalTo(cancleButton)
            $0.width.equalTo(1)
        }
        
        doneButton.snp.makeConstraints {
            $0.top.equalTo(cancleButton)
            $0.trailing.equalTo(alertView).offset(-16)
            $0.height.equalTo(35)
            $0.leading.equalTo(alertView.snp.centerX)
        }
    }
}
