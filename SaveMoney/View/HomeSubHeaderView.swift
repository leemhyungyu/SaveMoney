//
//  HomeSubHeaderView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/01.
//

import UIKit

class HomeSubHeaderView: UIView {
    
    var title: String?
    
    let headerLabel: UILabel = {
       
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.tintColor = .systemGray4
        return label
    }()
    
    let headerLabelLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray3
        return view
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        headerLabel.text = title
        
        [headerLabel, headerLabelLine] .forEach { addSubview($0) }
        
        headerLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        headerLabelLine.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(3)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
