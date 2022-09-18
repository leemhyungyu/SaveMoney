//
//  InputView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/10.
//

import UIKit
import SnapKit

class InputView: UIView {
    
    // MARK: - Properties

    let subView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = .white
        view.setShadow()
        
        return view
    }()
    
    let categoriLabel: UILabel = {
        let label = UILabel()
        
        label.text = "카테고리"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let categoriTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "물품명"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "순대국밥"
        return textField
    }()
    
    let moneyLabel: UILabel = {
        let label = UILabel()
        
        label.text = "가격(원)"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let moneyTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = "7000"
        
        return textField
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

extension InputView {
    
    func configureUI() {
        
        addSubview(subView)
        
        [categoriLabel, categoriTextField, nameLabel, nameTextField, moneyLabel, moneyTextField] .forEach { subView.addSubview($0) }
        
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        categoriLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }
        
        categoriTextField.snp.makeConstraints {
            $0.top.equalTo(categoriLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(300)
            $0.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(categoriTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(10)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        
        moneyLabel.snp.makeConstraints {
            $0.top.equalTo(categoriTextField.snp.bottom).offset(20)
            $0.leading.equalTo(nameTextField.snp.trailing).offset(10)
        }
        
        moneyTextField.snp.makeConstraints {
            $0.top.equalTo(moneyLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nameTextField.snp.trailing).offset(10)
            $0.width.equalTo(140)
            $0.height.equalTo(30)
        }
    }
}
