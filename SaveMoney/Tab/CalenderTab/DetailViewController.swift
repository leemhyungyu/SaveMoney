//
//  DetailViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/09/10.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    // MARK: - ViewModel
    
    let viewModel = DetailViewModel()
    
    // MARK: - Properties
    
    var updateButtonClosure: (() -> Void)?
    
    var detailView: DetailView = {
        let view = DetailView()
        
        view.setShadow()
        
        view.changeButton.addTarget(self, action: #selector(changeButtonClikced), for: .touchUpInside)
        view.deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        
        return view
        
    }()
    
    // MARK: - UIViewController - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setBackArrowNiavigationBar("상세보기")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        detailView.setView(save: viewModel.selectedSave)
    }
    
    // MARK: Actions
    
    @objc func changeButtonClikced() {
        let inputVC = InputViewController()
        
        inputVC.setInputVCData(save: viewModel.selectedSave)
    
        self.navigationController?.pushViewController(inputVC, animated: true)
        
        inputVC.updateBtnClosure = {
            self.presentWarningView(.change)
        }
    }
    
    @objc func deleteButtonClicked() {
        let alertView = presentAlertView(.delete)
        
        present(alertView, animated: true)
        
        alertView.doneButtonClosure = {
            self.viewModel.deleteSave()
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Functions

extension DetailViewController {
    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        [detailView] .forEach { view.addSubview($0) }
        
        detailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(300)
        }
    }
}
