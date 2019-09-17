//
//  BaseViewController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  private func configureView() {
    self.view.backgroundColor = CustomColor.orange
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  struct ExceptionHandler {
    static func parse(error: Error) -> String {
      let message: String
      if let dbException = error as? DBException {
        message = dbException.message
      } else {
        message = error.localizedDescription
      }
      return message
    }
  }
}

extension BaseViewController: BasicAlerting {
}

extension BaseViewController: UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
}
