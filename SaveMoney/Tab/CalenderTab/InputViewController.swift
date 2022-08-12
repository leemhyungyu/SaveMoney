//
//  InputViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/21.
//

import UIKit

class InputViewController: UIViewController {
    
    let viewModel = InputViewModel.shared

    var doneBtnClosure: (() -> Void)?
        
    let subView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let imaginView: InputView = {
        let view = InputView()
        
        return view
    }()
    
    let realView: InputView = {
        let view = InputView()
        view.isHidden = true
        
        return view
    }()
    
    lazy var checkBox: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let checkBoxLabel: UILabel = {
        let label = UILabel()
        
        label.text = "구매하지 않으셨나요?"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["상상", "현실"])
        control.tintColor = .systemPink
//        control.selectedSegmentTintColor = .systemPink
//        control.backgroundColor = .systemPink
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        
        return control
    }()
    
    lazy var backBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .systemPink
        config.image = UIImage(systemName: "arrow.left")
        config.imagePadding = 10
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(backBtnClicked(_:)), for: .touchUpInside)
        
        return btn
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
    
    let planPickerView: UIPickerView = {
        
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    lazy var toolbar: UIToolbar = {
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
    
    lazy var doneBtn: UIButton = {
       
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemPink
        config.imagePadding = 10
        
        var titleAttr = AttributedString.init("완료")
        titleAttr.font = .systemFont(ofSize: 16)
        config.attributedTitle = titleAttr
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(doneBtnClicked(_:)), for: .touchUpInside)
        
        return btn
    }()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setting()
    }
    
    func setting() {
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        viewModel.checkBoxData = false
        [subView, doneBtn, segmentedControl, imaginView, realView] .forEach { view.addSubview($0) }
        [label, infoLabel, backBtn] .forEach { subView.addSubview($0) }

        [checkBox, checkBoxLabel] .forEach { realView.addSubview($0) }
        planPickerView.delegate = self
        
        imaginView.categoriTextField.inputView = planPickerView
        imaginView.categoriTextField.inputAccessoryView = toolbar
        realView.categoriTextField.inputView = planPickerView
        realView.categoriTextField.inputAccessoryView = toolbar
                
        subView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        backBtn.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
        }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subView.snp.bottom).offset(10)
            $0.width.equalTo(200)
        }
        
        imaginView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
        
        realView.snp.makeConstraints {
            $0.edges.equalTo(imaginView)
            $0.height.equalTo(200)
        }
        
        doneBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
        
        checkBox.snp.makeConstraints {
            $0.top.equalTo(realView.categoriLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        checkBoxLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkBox)
            $0.trailing.equalTo(checkBox.snp.leading).offset(-3)
        }
    }
}

extension InputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return viewModel.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.categories[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        imaginView.categoriTextField.text = viewModel.categories[row].title
            
        realView.categoriTextField.text = viewModel.categories[row].title
    }
}

extension InputViewController {
    
    @objc func doneBtnOfToolbarClicked() {
        imaginView.categoriTextField.resignFirstResponder()
        realView.categoriTextField.resignFirstResponder()
    }
    
    @objc func cancleBtnOfToolbarClicked() {
        imaginView.categoriTextField.resignFirstResponder()
        realView.categoriTextField.resignFirstResponder()
    }
    
    @objc func backBtnClicked(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @objc func doneBtnClicked(_ sender: UITapGestureRecognizer) {
        // 완료 버튼을 눌렀을 떄
        
        // 필수 정보 (상상 - 카테고리, 물품명, 가격, 현실 - 만약 체크했으면 없고, 체크 안했으면 카테고리, 물품명, 가격)
        // 필수정보가 입력안됐을 떄 warningView띄워주고 완료되도 저장안되고 dismiss안되게
        // 필수정보가 다 입력됐으면 저장되고 dismiss되게
        
        // 방법 1
        // 각각의 프로퍼티들을 뷰모델에 정의를 해놓고 완료버튼을 누르면 뷰모델에 있는 프로퍼티에 값을 넣는 것임
        // 그러면 값이 들어온값과 안들어온 값을 구분할 수 있고
        // 값이 안들언온 필드는 색상을 다르게 해주면 될듯
        
        // 방법 2
        // 각각의 필드의 내용이 있는지 검사하는 메소드를 사용해서
        // 어떤 필드가 값이 안채워져있는지 확인해서 값이 없는 필드는 색상을 다르게 해주면 될듯 즉, textField.text.count == 0인 경우 텍스트필드의 색을 다르게 해주면 됨
        // 그리고 textField.text.count == 0 인것이 하나라도 있으면 완료를 눌렀을 떄 dismiss안되게하고 warningView띄워주면 될듯
        
        
        // 일단 먼저 체크가 되어있는지 안되어있는지부터 해야 할듯
        
        // 체크가 되어있는 경우
        guard let planName = imaginView.nameTextField.text, let planMoney = imaginView.moneyTextField.text, let category = imaginView.categoriTextField.text, var finalName = realView.nameTextField.text, var finalMoney = realView.moneyTextField.text else { return }
        
        if viewModel.checkBoxData == true {
            if imaginView.nameTextField.text?.count == 0 || imaginView.moneyTextField.text?.count == 0 || imaginView.categoriTextField.text?.count == 0 {
                presentWarningView()
            } else {
                
                addSaveData(date: viewModel.date!, planName: planName, finalName: "구매 X", planMoney: planMoney, finalMoney:  "0", category: category)
                dismiss(animated: true)
            }
        // 체크가 안되어있는 경우
        } else {
            if imaginView.nameTextField.text?.count == 0 || imaginView.moneyTextField.text?.count == 0 || imaginView.categoriTextField.text?.count == 0 || realView.nameTextField.text?.count == 0 || realView.moneyTextField.text?.count == 0 {
                
                presentWarningView()
            } else {

                addSaveData(date: viewModel.date!, planName: planName, finalName: finalName, planMoney: planMoney, finalMoney: finalMoney, category: category)
                dismiss(animated: true)
            }
        }
    }
    
    @objc func didChangeValue(segment: UISegmentedControl) {

        switch segment.selectedSegmentIndex {
        case 0:
            imaginView.isHidden = false
        case 1:
            imaginView.isHidden = true
        default:
            return
        }
        realView.isHidden = !imaginView.isHidden
    }
    
    @objc func checkButtonClicked() {
        
        checkBox.isSelected = !checkBox.isSelected
        
        if checkBox.isSelected == true {
            viewModel.checkBoxData = true
            realView.categoriTextField.backgroundColor = .systemGray5
            realView.moneyTextField.backgroundColor = .systemGray5
            realView.nameTextField.backgroundColor = .systemGray5
            
            realView.categoriTextField.isUserInteractionEnabled = false
            realView.moneyTextField.isUserInteractionEnabled = false
            realView.nameTextField.isUserInteractionEnabled = false
        } else {
            viewModel.checkBoxData = false
            realView.categoriTextField.backgroundColor = .white
            realView.moneyTextField.backgroundColor = .white
            realView.nameTextField.backgroundColor = .white
            
            realView.categoriTextField.isUserInteractionEnabled = true
            realView.moneyTextField.isUserInteractionEnabled = true
            realView.nameTextField.isUserInteractionEnabled = true
        }
    }
    
    func addSaveData(date: Date, planName: String, finalName: String, planMoney: String, finalMoney: String, category: String) {
        let save = viewModel.createSave(date: viewModel.date!, planName: planName, finalName: finalName, planMoney: planMoney, finalMoney: finalMoney, category: category)
        
        viewModel.addSave(save: save)
        viewModel.addEventDay(save: save)
        viewModel.addSelectedDay(save: save)
    }
}
