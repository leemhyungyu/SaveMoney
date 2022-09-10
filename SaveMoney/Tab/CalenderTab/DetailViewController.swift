//
//  DetailViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/09/10.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var detailView: DetailView = {
        let view = DetailView()
        
        view.setShadow()
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setBackArrowNiavigationBar("상세보기")
    }
    
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
