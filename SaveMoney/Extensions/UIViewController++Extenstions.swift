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
    
    func setBackArrowNiavigationBar(_ title: String ) {
        
        self.navigationItem.title = title
        self.navigationItem.hidesBackButton = true
        
        let config = UIImage.SymbolConfiguration(weight: .regular)
        
        let backButton = UIBarButtonItem(
            image: UIImage(
                systemName: "arrow.left",
                withConfiguration: config)?.withTintColor(.systemPink, renderingMode: .alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(popNavigationController))
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func presentInputViewController() {
        let inputVC = InputViewController()
        
        self.navigationController?.pushViewController(inputVC, animated: true)
    }
    
    @objc func presentMypageViewController() {
        let myPageVC = MyPageViewController()
        
        self.navigationController?.pushViewController(myPageVC, animated: true)
    }
    
    @objc func popNavigationController() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    func setTabNavigationBar(_ title: String) {
        
        self.navigationController?.navigationBar.topItem?.title = title
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}
