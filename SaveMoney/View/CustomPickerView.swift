//
//  CustomPickerView.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/09/04.
//

import UIKit
import SnapKit

class CustomPickerView: UIView {
    
    var pickerLabel: String?
    var pickerImage: UIImage?
    
    let label: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 25, weight: .light)
        label.textAlignment = .center
        
        return label
    }()
    
    let imageView: UIImageView = {
        var imageView = UIImageView()
        
        imageView.tintColor = .systemPink
        return imageView
    }()
    
    init(pickerLabel: String, pickerImage: UIImage) {
        self.label.text = pickerLabel
        self.imageView.image = pickerImage
        super.init(frame: .zero)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        [label, imageView] .forEach { addSubview($0) }
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(label.snp.trailing).offset(5)
        }
    }
}
