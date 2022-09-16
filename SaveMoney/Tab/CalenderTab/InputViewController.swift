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
    
    let imaginPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
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
        
        doneBtn.tintColor = .systemPink
        cancleBtn.tintColor = .systemPink
        
        toolbar.setItems([cancleBtn, space, doneBtn], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()
    
    lazy var doneBtn: UIButton = {
       
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemPink
        config.imagePadding = 10
        
        var titleAttr = AttributedString.init("완료")
        titleAttr.font = .systemFont(ofSize: 16, weight: .semibold)
        config.attributedTitle = titleAttr
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(doneBtnClicked(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var updateButton: UIButton = {
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemPink
        config.imagePadding = 10
        
        var titleAttr = AttributedString.init("수정하기")
        titleAttr.font = .systemFont(ofSize: 16, weight: .semibold)
        config.attributedTitle = titleAttr
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(updateButtonClicked(_:)), for: .touchUpInside)
        
        btn.isHidden = true
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setting()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        imaginView.nameTextField.resignFirstResponder()
        imaginView.moneyTextField.resignFirstResponder()
        imaginView.categoriTextField.resignFirstResponder()
        
        realView.nameTextField.resignFirstResponder()
        realView.moneyTextField.resignFirstResponder()
        realView.categoriTextField.resignFirstResponder()
    }
    
    func setting() {
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setBackArrowNiavigationBar("절약하기")
        [subView, doneBtn, updateButton, segmentedControl, imaginView, realView] .forEach { view.addSubview($0) }
        [label, infoLabel] .forEach { subView.addSubview($0) }
        [checkBox, checkBoxLabel] .forEach { realView.addSubview($0) }
    
        planPickerView.delegate = self
        imaginPickerView.delegate = self
        imaginView.moneyTextField.delegate = self
        imaginView.nameTextField.delegate = self
        realView.moneyTextField.delegate = self
        realView.nameTextField.delegate = self
        
        imaginView.categoriTextField.inputView = imaginPickerView
        imaginView.categoriTextField.inputAccessoryView = toolbar
        imaginPickerView.backgroundColor = .white
        
        realView.categoriTextField.inputView = planPickerView
        realView.categoriTextField.inputAccessoryView = toolbar
        planPickerView.backgroundColor = .white
        
        subView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(100)
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
        
        updateButton.snp.makeConstraints {
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
  
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return viewModel.categories.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {


        let view = CustomPickerView(pickerLabel: viewModel.categories[row].title, pickerImage: viewModel.categories[row].imageView)

        view.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView == planPickerView {
            realView.categoriTextField.text = viewModel.categories[row].title
        } else if pickerView == imaginPickerView {
            imaginView.categoriTextField.text = viewModel.categories[row].title
        }
    }
}

extension InputViewController {
    
    @objc func doneBtnOfToolbarClicked() {
        imaginView.categoriTextField.resignFirstResponder()
        realView.categoriTextField.resignFirstResponder()
    }
    
    @objc func cancleBtnOfToolbarClicked() {

        switch segmentedControl.selectedSegmentIndex {
        case 0: // 상상
            imaginView.categoriTextField.resignFirstResponder()
            imaginView.categoriTextField.text = ""
        case 1: // 현실
            realView.categoriTextField.resignFirstResponder()
            realView.categoriTextField.text = ""
        default:
            return
        }
    }
    
    @objc func doneBtnClicked(_ sender: UITapGestureRecognizer) {

        guard let planName = imaginView.nameTextField.text, let planMoney = imaginView.moneyTextField.text, let category = imaginView.categoriTextField.text, let finalName = realView.nameTextField.text, let finalMoney = realView.moneyTextField.text else { return }
        
        if viewModel.checkBoxData == true {
            if imaginView.nameTextField.text?.count == 0 || imaginView.moneyTextField.text?.count == 0 || imaginView.categoriTextField.text?.count == 0 {
                presentWarningView(.input)
            } else {
                addSaveData(date: viewModel.date, planName: planName, finalName: "구매 X", planMoney: planMoney, finalMoney:  "0", category: category, check: true)
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            if imaginView.nameTextField.text?.count == 0 || imaginView.moneyTextField.text?.count == 0 || imaginView.categoriTextField.text?.count == 0 || realView.nameTextField.text?.count == 0 || realView.moneyTextField.text?.count == 0 {
                
                presentWarningView(.input)
            } else {
                addSaveData(date: viewModel.date, planName: planName, finalName: finalName, planMoney: planMoney, finalMoney: finalMoney, category: category, check: false)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func updateButtonClicked(_ sender: UITapGestureRecognizer) {
        
        guard let planName = imaginView.nameTextField.text, let planMoney = imaginView.moneyTextField.text, let category = imaginView.categoriTextField.text, let finalName = realView.nameTextField.text, let finalMoney = realView.moneyTextField.text else { return }
        
        if viewModel.checkBoxData == true {
            if imaginView.nameTextField.text?.count == 0 || imaginView.moneyTextField.text?.count == 0 || imaginView.categoriTextField.text?.count == 0 {
                presentWarningView(.input)
            } else {

                
                let save = viewModel.setUpdateSave(planName: planName, finalName: "구매 X", planMoney: planMoney, finalMoney: "0", category: category, check: true)
                
                viewModel.updateSave(save: save)
                viewModel.updateSelectedSave()
                
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            if imaginView.nameTextField.text?.count == 0 || imaginView.moneyTextField.text?.count == 0 || imaginView.categoriTextField.text?.count == 0 || realView.nameTextField.text?.count == 0 || realView.moneyTextField.text?.count == 0 {
                
                presentWarningView(.input)
            } else {
                
                let save = viewModel.setUpdateSave(planName: planName, finalName: finalName, planMoney: planMoney, finalMoney: finalMoney, category: category, check: false)
                
                viewModel.updateSave(save: save)
                viewModel.updateSelectedSave()

                self.navigationController?.popViewController(animated: true)
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
        
        setCheckBoxUI(checkBox.isSelected)
    }
    
    func setCheckBoxUI(_  bool: Bool) {
        
        if bool == true {
            viewModel.checkBoxData = true
            
            realView.categoriTextField.text = ""
            realView.moneyTextField.text = ""
            realView.nameTextField.text = ""
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
    
    func addSaveData(date: Date, planName: String, finalName: String, planMoney: String, finalMoney: String, category: String, check: Bool) {
        let save = viewModel.createSave(date: viewModel.date, planName: planName, finalName: finalName, planMoney: planMoney, finalMoney: finalMoney, category: category, check: check)
        
        viewModel.addSave(save: save)
        viewModel.addEventDay(save: save)
        viewModel.addSelectedDay(save: save)
        
    }
    
    func setInputVCData(save: Save) {
        
        viewModel.checkBoxData = save.check
        doneBtn.isHidden = true
        updateButton.isHidden = false
        
        self.label.text = getMonthAndDayForString(date: save.day)
        self.imaginView.categoriTextField.text = save.category
        self.imaginView.nameTextField.text = save.planName
        self.imaginView.moneyTextField.text = save.planMoney
        
        // 구매하지 않았을 경우
        if save.check == true  {
            self.checkBox.isSelected = true
            setCheckBoxUI(save.check)
        } else {
            self.realView.categoriTextField.text =  save.category
            self.realView.nameTextField.text = save.finalName
            self.realView.moneyTextField.text = save.finalMoney
        }
    }
}

extension InputViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
