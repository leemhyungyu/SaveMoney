//
//  InputViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/21.
//

import UIKit

class InputViewController: UIViewController {
    
    let viewModel = InputViewModel()

    let subView: UIView = {
        let subView = UIView()

        return subView
    }()
    
    let planView: UIView = {
        let view = UIView()
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let backBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrow.left")
        config.imagePadding = 10
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(backBtnClicked(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    let finalView: UIView = {
        let view = UIView()
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    lazy var label: UILabel = {
       
        let label = UILabel()
        
        label.text = "6월 22일"
        
        label.font = .systemFont(ofSize: 30)
        
        return label
    }()
    
    let planViewLabel: UILabel = {
        let label = UILabel()
        
        label.text = "구매하려한 물품"
        
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        
        label.text = "구매하신 정보를 입력해주세요!"
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()

    
    let planCategoriLabel: UILabel = {
        let label = UILabel()
        
        label.text = "카테고리"
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let planNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "물품명"
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let planMoneyLabel: UILabel = {
        
        let label = UILabel()
        label.text = "가격(원)"
        label.font = .systemFont(ofSize: 16)

        return label
    }()
    
    let planCategoriInput: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    let planNameInput: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "순대국밥"

        return textField
    }()
    
    let planMoneyInput: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = "7000"
        
        return textField
    }()
    
    let finalViewLabel: UILabel = {
        
        let label = UILabel()
        label.text = "구매한 내역"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    

    let finalCategoriLabel: UILabel = {
        
        let label = UILabel()
        label.text = "카테고리"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let finalNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "물품명"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let finalMoneyLabel: UILabel = {
        
        let label = UILabel()
        label.text = "가격(원)"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let finalCategoriInput: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    let finalNameInput: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "컵밥"

        return textField
    }()
    
    let finalMoneyInput: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = "3500"
        
        return textField
    }()
    
    let planPickerView: UIPickerView = {
        
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    let finalPickerView: UIPickerView = {
        
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
    
    let doneBtn: UIButton = {
       
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.imagePadding = 10
        
        var titleAttr = AttributedString.init("완료")
        titleAttr.font = .systemFont(ofSize: 16)
        config.attributedTitle = titleAttr
        
        let btn = UIButton(configuration: config)
        
        btn.addTarget(self, action: #selector(doneBtnClicked(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    let categoriDate = ["식비", "교통", "취미", "생활", "커피", "기타"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setting()
        print(viewModel.saves)
    }
    
    func setting() {
        
        view.addSubview(subView)
        view.addSubview(planView)
        view.addSubview(planViewLabel)
        view.addSubview(finalView)
        view.addSubview(finalViewLabel)
        view.addSubview(doneBtn)
        
        subView.addSubview(label)
        subView.addSubview(infoLabel)
        subView.addSubview(backBtn)

        
        planView.addSubview(planCategoriLabel)
        planView.addSubview(planCategoriInput)
        planView.addSubview(planNameInput)
        planView.addSubview(planNameLabel)
        planView.addSubview(planMoneyInput)
        planView.addSubview(planMoneyLabel)
        
        finalView.addSubview(finalCategoriLabel)
        finalView.addSubview(finalCategoriInput)
        finalView.addSubview(finalNameInput)
        finalView.addSubview(finalNameLabel)
        finalView.addSubview(finalMoneyInput)
        finalView.addSubview(finalMoneyLabel)
        
        planView.backgroundColor = .systemGray5
        finalView.backgroundColor = .systemGray5

        planPickerView.delegate = self
        planCategoriInput.inputView = planPickerView
        planCategoriInput.inputAccessoryView = toolbar
        
        finalPickerView.delegate = self
        finalCategoriInput.inputView = finalPickerView
        finalCategoriInput.inputAccessoryView = toolbar
        
        backBtn.snp.makeConstraints {
            $0.top.equalTo(subView).offset(10)
            $0.leading.equalTo(subView).offset(5)
        }
        subView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        planViewLabel.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).inset(10)
            $0.leading.equalTo(planView.snp.leading)
        }
        
        planView.snp.makeConstraints {
            $0.top.equalTo(planViewLabel.snp.bottom).inset(-10)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(160)
        }
        
        finalViewLabel.snp.makeConstraints {
            $0.top.equalTo(planView.snp.bottom).inset(-10)
            $0.leading.equalTo(planView.snp.leading)
        }
        
        finalView.snp.makeConstraints {
            $0.top.equalTo(finalViewLabel.snp.bottom).inset(-10)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(160)
        }
        
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        planCategoriLabel.snp.makeConstraints {
            $0.top.equalTo(planViewLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
        }
        
        planCategoriInput.snp.makeConstraints {
            $0.top.equalTo(planCategoriLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(300)
            $0.height.equalTo(30)
        }
        
        planNameLabel.snp.makeConstraints {
            $0.top.equalTo(planCategoriInput.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
        }
        
        planNameInput.snp.makeConstraints {
            $0.top.equalTo(planNameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        
        planMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(planCategoriInput.snp.bottom).offset(20)
            $0.leading.equalTo(planMoneyInput.snp.leading)
        }
        
        planMoneyInput.snp.makeConstraints {
            $0.top.equalTo(planMoneyLabel.snp.bottom).offset(10)
            $0.leading.equalTo(planNameInput.snp.trailing).offset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }

        finalCategoriLabel.snp.makeConstraints {
            $0.top.equalTo(finalViewLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
        }

        finalCategoriInput.snp.makeConstraints {
            $0.top.equalTo(finalCategoriLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(300)
            $0.height.equalTo(30)
        }

        finalNameLabel.snp.makeConstraints {
            $0.top.equalTo(finalCategoriInput.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
        }

        finalNameInput.snp.makeConstraints {
            $0.top.equalTo(finalNameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }

        finalMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(finalCategoriInput.snp.bottom).offset(20)
            $0.leading.equalTo(finalMoneyInput.snp.leading)
        }

        finalMoneyInput.snp.makeConstraints {
            $0.top.equalTo(finalMoneyLabel.snp.bottom).offset(10)
            $0.leading.equalTo(finalNameInput.snp.trailing).offset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        
        doneBtn.snp.makeConstraints {
            $0.top.equalTo(finalView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
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
        
        if pickerView == planPickerView {
            planCategoriInput.text =  viewModel.categories[row].title

        } else {
            finalCategoriInput.text = viewModel.categories[row].title
        }
        
    }
}

extension InputViewController {
    
    @objc func doneBtnOfToolbarClicked() {
        planCategoriInput.resignFirstResponder()
    }
    
    @objc func cancleBtnOfToolbarClicked() {
        
        planCategoriInput.text = ""
        planCategoriInput.resignFirstResponder()
    }
    
    @objc func backBtnClicked(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @objc func doneBtnClicked(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
        
        guard let day = label.text, let planName = planNameInput.text, let planMoney = planMoneyInput.text, let finalName = finalNameInput.text, let finalMoney = finalMoneyInput.text, let category = finalCategoriInput.text else { return }
        
        let save = viewModel.saveManager.createSave(day: day, planName: planName, finalName: finalName, planMoney: planMoney, finalMoney: finalMoney, category: category)
        
        viewModel.addSave(save: save)
        viewModel.addEventDay(save: save)
    }
}
