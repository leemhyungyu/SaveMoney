//
//  UIButton++Extensions.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/13.
//

import Foundation
import UIKit

extension UIButton {
    
    func setButtonShape(title: String) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 25)
        self.setTitleColor(UIColor.lightGray, for: .normal)
        self.setTitleColor(UIColor.systemPink, for: .selected)
    }
    
    func setSettingVCButton() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "gearshape.fill")
        
        self.configuration = config
        self.tintColor = .systemPink
    }
}

