//
//  BasicAlerting.swift
//  gud-ios
//
//  Created by sudofluff on 8/23/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

enum BasicAlertType: String {
  case error = "Error"
  
  case warning = "Warning"
  
  case success = "Success"
  
  var description: String {
    return self.rawValue
  }
}

protocol BasicAlerting where Self: UIViewController {
  func makeAlert(_ message: String, alertType: BasicAlertType, style: UIAlertController.Style) -> UIAlertController
  
  func presentAlert(_ message: String, alertType: BasicAlertType, style: UIAlertController.Style, completion: (() -> Void)?)
}

extension BasicAlerting {
  func makeAlert(_ message: String, alertType: BasicAlertType, style: UIAlertController.Style = .alert) -> UIAlertController {
    let controller = UIAlertController(title: alertType.description, message: message, preferredStyle: style)
    let act = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    controller.addAction(act)
    return controller
  }
  
  func presentAlert(_ message: String, alertType: BasicAlertType, style: UIAlertController.Style = .alert, completion: (() -> Void)?) {
    let controller = self.makeAlert(message, alertType: alertType, style: style)
    self.present(controller, animated: true, completion: completion)
  }
}
