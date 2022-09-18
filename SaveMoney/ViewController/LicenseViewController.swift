//
//  LicenseViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/19.
//

import UIKit
import SnapKit
class LicenseViewController: UIViewController {
    
    // MARK: - ViewModel

    let viewModel = LicenseViewModel()
    
    // MARK: - Properties

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        return tableView
    }()
    
    // MARK: - UIViewController - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setBackArrowNiavigationBar("오픈소스 라이브러리")
        configureUI()
    }
}

// MARK: - UITableViewDelegate

extension LicenseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfCell
    }
}

// MARK: - UITableViewDataSource

extension LicenseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LicenseCell.identifier, for: indexPath) as? LicenseCell else { return UITableViewCell() }
        
        cell.label.text = viewModel.titleOfCell(indexPath.row)
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = LicenseInfoViewController()
        
        viewController.bodyLabel.text = viewModel.bodyOfCell(indexPath.row)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Functions

extension LicenseViewController {
    func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(LicenseCell.self, forCellReuseIdentifier: LicenseCell.identifier)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
