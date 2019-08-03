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
  
  private var taskListCoordinator: TaskListCoordinator?
  
  init(presenter: AppTabBarController) {
    self.presenter = presenter
    super.init()
  }
}

extension AppCoordinator: Coordinatable {
  func start() {
    let options = TaskListDependencyOptions(networkService: GudNetworkService(), cacheService: TaskListDataStore())
    self.taskListCoordinator = TaskListCoordinator(presenter: presenter, options: options)
    self.taskListCoordinator?.start()
  }
}
