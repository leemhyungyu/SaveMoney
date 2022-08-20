//
//  LicenseViewModel.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/21.
//

import Foundation
import UIKit

class LicenseViewModel {
    
    let Licenses: [License] = [.SnapKit, .FSCalender, .SwiftMessages, .Charts, .ExpyTableView]
    
    var numOfCell: Int {
        return Licenses.count
    }
    
    func titleOfCell(_ index: Int) -> String {
        return Licenses[index].title
    }
    
    func bodyOfCell(_ index: Int) -> String {
        return Licenses[index].body
    }
    
    func sizeOfCell(index: Int, width: CGFloat) -> CGFloat {

        let titleLabel = UILabel()
        titleLabel.frame.size.width = width - 40
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.text = Licenses[index].title
        titleLabel.sizeToFit()

        let bodyLabel = UILabel()
        bodyLabel.frame.size.width = width - 40
        bodyLabel.numberOfLines = 0
        bodyLabel.text = Licenses[index].body
        bodyLabel.sizeToFit()
        
        return CGFloat(titleLabel.frame.size.height + bodyLabel.frame.size.height + 40)
    }
}
