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
    
    let imaginView = InputView()
    let realView = InputView()
    
    let subView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        return view
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["상상", "현실"])
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
        
        [subView, doneBtn, segmentedControl, imaginView, realView] .forEach { view.addSubview($0) }
        [label, infoLabel, backBtn] .forEach { subView.addSubview($0) }

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
        }
        
        imaginView.snp.makeConstraints {
            imaginView.backgroundColor = .white
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
        dismiss(animated: true)
        
        guard let planName = imaginView.nameTextField.text, let planMoney = imaginView.moneyTextField.text, let finalName = realView.nameTextField.text, let finalMoney = realView.moneyTextField.text, let category = realView.categoriTextField.text else { return }
        
        let save = viewModel.saveManager.createSave(day: getStringToDate(date: viewModel.date!), planName: planName, finalName: finalName, planMoney: planMoney, finalMoney: finalMoney, category: category)
        
        viewModel.addSave(save: save)
        viewModel.addEventDay(save: save)
        viewModel.addSelectedDay(save: save)
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
}
