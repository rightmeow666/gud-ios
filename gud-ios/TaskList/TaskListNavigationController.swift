//
//  TaskListNavigationController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskListNavigationController: BaseNavigationController {
  private func configureView() {
    self.tabBarItem.title = "Tasks"
    self.tabBarItem.image = UIImage(named: "Tasks")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}
