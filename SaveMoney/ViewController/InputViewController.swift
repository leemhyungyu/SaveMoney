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
    
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(doneBtnOfToolbarClicked))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancleBtn = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(cancleBtnOfToolbarClicked))
        
        toolbar.setItems([cancleBtn, space, doneBtn], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
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
        textField.placeholder = "순대국밥"

        return textField
    }()
    
    let moneyinput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray5
        textField.keyboardType = .numberPad
        textField.placeholder = "7000"
        return textField
    }()
    
    let categoriDate = ["식비", "교통", "취미", "생활", "커피", "기타"]
    
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
        
        pickerView.delegate = self
        categoriinput.inputView = pickerView
        categoriinput.inputAccessoryView = toolbar

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

extension InputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriDate.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriDate[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoriinput.text =  categoriDate[row]
    }
}

extension InputViewController {
    
    @objc func doneBtnOfToolbarClicked() {
        categoriinput.resignFirstResponder()
    }
    
    @objc func cancleBtnOfToolbarClicked() {
        categoriinput.text = ""
        categoriinput.resignFirstResponder()
    }
}
