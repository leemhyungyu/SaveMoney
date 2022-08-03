//
//  AlertViewController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/08/04.
//

import UIKit
import SnapKit

class AlertViewCotroller: UIViewController {
    
    let alertView = AlertView()
    var alert: Alert?
    var doneButtonClosure: (() -> Void)?
    
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    func setViewController() {
        alertView.titleLabel.text = alert?.title
        alertView.bodyLabel.text = alert?.body
        
        alertView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController(_:)))
        
        alertView.cancleButton.addTarget(
            self,
            action: #selector(dismissViewController(_:)),
            for: .touchUpInside)
        
        alertView.doneButton.addTarget(
            self,
            action: #selector(doneButtonClicked),
            for: .touchUpInside)
    }
    
    @objc func dismissViewController(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func doneButtonClicked() {
        print("doneButtonClicked() - called")
        if let doneButtonClosure = doneButtonClosure {
            doneButtonClosure()
            self.dismiss(animated: true)
        }
    }
}
