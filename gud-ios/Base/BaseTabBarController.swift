//
//  BaseTabBarController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
  private func configureView() {
    self.tabBar.backgroundColor = .orange
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}
