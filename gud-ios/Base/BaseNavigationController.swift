//
//  BaseNavigationController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
  private func configureView() {
    self.navigationBar.backgroundColor = .orange
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}
