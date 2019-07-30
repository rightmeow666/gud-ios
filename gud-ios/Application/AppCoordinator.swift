//
//  AppCoordinator.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject {
  private let presenter: AppTabBarController
  
  private var taskListCoordinator: TaskListCoordinator
  
  private var coordinators: [Coordinatable] {
    return [taskListCoordinator]
  }
  
  init(presenter: AppTabBarController) {
    self.presenter = presenter
    self.taskListCoordinator = TaskListCoordinator(presenter: presenter)
    super.init()
  }
}

extension AppCoordinator: Coordinatable {
  func start() {
    self.taskListCoordinator.start()
  }
}
