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
}
