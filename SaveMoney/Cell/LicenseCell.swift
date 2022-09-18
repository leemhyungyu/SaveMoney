//
//  LicenseCell.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/21.
//
import UIKit
import SnapKit

class LicenseCell: UITableViewCell {
    
    // MARK: - Identifier

    static let identifier = "LicenseCell"
    
    // MARK: - Properties
    
    lazy var label: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Functions

extension LicenseCell {
    func configureUI() {
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
    }
}
