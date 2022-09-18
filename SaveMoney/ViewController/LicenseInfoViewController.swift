//
//  LicenseInfoViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/21.
//
import UIKit
import SnapKit

class LicenseInfoViewController: UIViewController {
    
    // MARK: - Properties

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    var bodyLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - UIViewController - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setBackArrowNiavigationBar("오픈소스 라이브러리")
        configureUI()
    }
}

// MARK: - Functions

extension LicenseInfoViewController {
    func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(bodyLabel)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        bodyLabel.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView)
        }
    }
}
