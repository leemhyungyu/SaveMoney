//
//  EmptyCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/12.
//

import UIKit
import SnapKit

class EmptyCell: UICollectionViewCell {
    
    // MARK: - Identifier

    static let identifier = "EmptyCell"
    
    // MARK: - Properties

    let subView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setShadow()
        
        return view
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        
        label.text = "아직 절약한 내용이 없습니다!"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemGray
        
        return label
    }()
    
    let imageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.tintColor = .systemGray
        imageView.image = UIImage(systemName: "rectangle.on.rectangle.slash")
        
        return imageView
    }()
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Functions

extension EmptyCell {
    
    func configureUI() {
        addSubview(subView)
        
        [emptyLabel, imageView] .forEach { subView.addSubview($0) }
        
        subView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalTo(subView.snp.centerX).offset(30)
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(emptyLabel.snp.leading).offset(-10)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
    }
}
