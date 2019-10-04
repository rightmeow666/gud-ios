//
//  BasicAlerting.swift
//  gud-ios
//
//  Created by sudofluff on 8/23/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol BasicAlerting where Self: UIViewController {
  func makeAlert(_ message: String, alertType: AlertType, style: UIAlertController.Style) -> UIAlertController
  
  func presentAlert(_ message: String, alertType: AlertType, style: UIAlertController.Style, completion: (() -> Void)?)
}

extension BasicAlerting {
  func makeAlert(_ message: String, alertType: AlertType, style: UIAlertController.Style = .alert) -> UIAlertController {
    let c = UIAlertController(title: alertType.description, message: message, preferredStyle: style)
    let act = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    c.addAction(act)
    return c
  }
  
  func presentAlert(_ message: String, alertType: AlertType, style: UIAlertController.Style = .alert, completion: (() -> Void)?) {
    let c = self.makeAlert(message, alertType: alertType, style: style)
    self.present(c, animated: true, completion: completion)
  }
}
