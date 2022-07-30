//
//  HomeView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/07/30.
//

import UIKit

class HomeHeaderView: UIView {
    
    var title: String?
    
    let headerView: UIView = {
        
        let view = UIView()
        
        view.layer.masksToBounds = false
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMinXMinYCorner)
        
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
    
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
        
        addSubview(headerView)
        
        headerView.addSubview(headerLabel)
        
        headerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
