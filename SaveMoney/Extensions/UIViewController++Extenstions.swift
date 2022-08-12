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
}
