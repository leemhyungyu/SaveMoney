//
//  UserViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//

import UIKit

class SettingViewController: UIViewController {

    let viewModel = SettingViewModel()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        
        tableView.layer.shadowColor = UIColor.systemGray.cgColor
        tableView.layer.masksToBounds = false
        tableView.layer.shadowRadius = 7
        tableView.layer.shadowOpacity = 0.4
        tableView.layer.cornerRadius = 8
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9933428168, green: 0.9469488263, blue: 0.9725527167, alpha: 1)
        configureUI()
        setBackArrowNiavigationBar("설정")
    }
    
    func configureUI() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else { return UITableViewCell() }
        
        cell.label.text = viewModel.titleOfcell(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let alert = presentAlertView(.initialization)
            present(alert, animated: true)
            alert.doneButtonClosure = {
                self.viewModel.initializationData()
                self.presentWarningView(.initialization)
            }
            
        case 1:
            break
        case 2:
            break
        case 3:
            let LicenseVC = LicenseViewController()
            navigationController?.pushViewController(LicenseVC, animated: true)
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
