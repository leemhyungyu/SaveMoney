//
//  UIViewController++Extenstions.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/04.
//

import Foundation
import UIKit
import Toast_Swift

extension UIViewController {
    func presentDetailViewController(_ save: Save, _ check: Bool) {
        let DetailVC = DetailViewController()
        DetailVC.detailView.setView(save: save)
        DetailVC.detailView.setDiffrentView(check)
        
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
    
    func presentAlertView(_ Alert: Alert) -> AlertViewCotroller {
        let alertViewController = AlertViewCotroller()
        alertViewController.alert = Alert
        alertViewController.modalTransitionStyle = .crossDissolve
        alertViewController.modalPresentationStyle = .overFullScreen
        return alertViewController
    }
    
    func presentWarningView(_ Warning: Warning) {
        let warningViewWidth = UIScreen.main.bounds.width - 40
        
        let toastPointX = UIScreen.main.bounds.width / 2
        
        let toastPointY = UIScreen.main.bounds.height / 1.3
        
        let warningView = WarningView(frame: CGRect(x: 0, y: 0, width: warningViewWidth, height: 52))
        
        warningView.warningLabel.text = Warning.body
        
        self.view.showToast(warningView, duration: 1.5, point: CGPoint(x: toastPointX, y: toastPointY))
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
    
    @objc func popNavigationController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func presentSettingViewController() {
        let settingVC = SettingViewController()
        
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    func setTabNavigationBar(_ title: String) {
        
        self.navigationController?.navigationBar.topItem?.title = title
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}
