//
//  InputViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/21.
//

import UIKit

class InputViewController: UIViewController {
    
    
    let subView: UIView = {
        let subView = UIView()
        
        return subView
    }()
    
    let infoView: UIView = {
        let view = UIView()
    
        return view
    }()
    
    
    lazy var label: UILabel = {
       
        let label = UILabel()
        
        label.text = "6월 22일"
        
        label.font = .systemFont(ofSize: 30)
        
        return label
    }()
    
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        
        label.text = "구매하신 정보를 입력해주세요!"
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()

    
    let categoriLabel: UILabel = {
        let label = UILabel()
        
        label.text = "카테고리"
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "물품명"
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let moneyLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "가격(원)"
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let categoriinput: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray5
        return textField
    }()
    
    let nameinput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray5
        return textField
    }()
    
    let moneyinput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray5
        return textField
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setting()
    }
    
    func setting() {
        view.addSubview(subView)
        view.addSubview(infoView)
        
        subView.addSubview(label)
        subView.addSubview(infoLabel)
        
        
        infoView.addSubview(categoriLabel)
        infoView.addSubview(categoriinput)
        infoView.addSubview(nameinput)
        infoView.addSubview(nameLabel)
        infoView.addSubview(moneyinput)
        infoView.addSubview(moneyLabel)
        
        subView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).offset(-30)
            $0.trailing.leading.bottom.equalToSuperview().inset(20)
        }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        categoriLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        categoriinput.snp.makeConstraints {
            $0.top.equalTo(categoriLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(300)
            $0.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(categoriinput.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
        }
        
        nameinput.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        
        moneyLabel.snp.makeConstraints {
            $0.top.equalTo(categoriinput.snp.bottom).offset(20)
//            $0.trailing.equalToSuperview().offset(-20)
            $0.leading.equalTo(moneyinput.snp.leading)
        }
        
        moneyinput.snp.makeConstraints {
            $0.top.equalTo(moneyLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nameinput.snp.trailing).offset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
    }
}
