//
//  UIViewController++Extenstions.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/04.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlertView(_ Alert: Alert) -> AlertViewCotroller {
        let alertViewController = AlertViewCotroller()
        alertViewController.alert = Alert
        alertViewController.modalTransitionStyle = .crossDissolve
        alertViewController.modalPresentationStyle = .overFullScreen
        return alertViewController
    }
}
