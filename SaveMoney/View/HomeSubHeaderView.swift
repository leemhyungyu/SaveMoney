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
        
        [headerLabel] .forEach { addSubview($0) }
        
        headerLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        } 
    }
}
