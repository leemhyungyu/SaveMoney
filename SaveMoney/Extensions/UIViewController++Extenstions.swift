//
//  UIViewController++Extenstions.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/04.
//

import Foundation
import UIKit
import SwiftMessages

extension UIViewController {
    func presentAlertView(_ Alert: Alert) -> AlertViewCotroller {
        let alertViewController = AlertViewCotroller()
        alertViewController.alert = Alert
        alertViewController.modalTransitionStyle = .crossDissolve
        alertViewController.modalPresentationStyle = .overFullScreen
        return alertViewController
    }
    
    func presentWarningView(_ Warning: Warning) {
        let warningView = WarningView()
        
        warningView.warningLabel.text = Warning.body
        var config = SwiftMessages.Config()
        config.duration = .seconds(seconds: 1)
        config.keyboardTrackingView = KeyboardTrackingView()
        config.presentationStyle = .center
        SwiftMessages.show(config: config, view: warningView)
    }
    
    func setTabNavigationBar() {
        let settingButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .done,
            target: self,
            action: #selector(presentMypageViewController))
        
        let AddButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle"),
            style: .done,
            target: self,
            action: #selector(presentInputViewController))
        
        settingButton.tintColor = .systemPink
        AddButton.tintColor = .systemPink
        
        self.navigationItem.leftBarButtonItem = settingButton
        self.navigationItem.rightBarButtonItem = AddButton
    }
    
    @objc func presentInputViewController() {
        let inputVC = InputViewController()
        
        self.navigationController?.pushViewController(inputVC, animated: true)
    }
    
    @objc func presentMypageViewController() {
        let myPageVC = MyPageViewController()
        
        self.navigationController?.pushViewController(myPageVC, animated: true)
    }
}
