//
//  AppTabBarController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class AppTabBarController: BaseTabBarController {
  var viewModel: AppViewModel!
  
  weak var viewControllerDelegate: AppTabBarControllerDelegate?
  
  private func configureView() {
    self.tabBar.backgroundColor = CustomColor.black
    self.tabBar.isTranslucent = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}
