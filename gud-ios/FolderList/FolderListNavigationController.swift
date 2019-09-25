//
//  FolderListNavigationController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class FolderListNavigationController: BaseNavigationController {
  private func configureView() {
    self.tabBarItem.title = "Folders"
    self.tabBarItem.image = UIImage(named: "Folders")
    self.navigationBar.prefersLargeTitles = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}
