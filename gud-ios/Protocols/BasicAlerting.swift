//
//  BasicAlerting.swift
//  gud-ios
//
//  Created by sudofluff on 8/23/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol BasicAlerting where Self: UIViewController {
  func makeAlert(_ title: String, message: String) -> UIAlertController
  
  func presentAlert(_ title: String, message: String, completion: (() -> Void)?)
}

extension BasicAlerting {
  func makeAlert(_ title: String, message: String) -> UIAlertController {
    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let act = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    controller.addAction(act)
    return controller
  }
  
  func presentAlert(_ title: String, message: String, completion: (() -> Void)?) {
    let controller = self.makeAlert(title, message: message)
    self.present(controller, animated: true, completion: completion)
  }
}
