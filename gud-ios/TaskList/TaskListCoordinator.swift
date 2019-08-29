//
//  TaskListCoordinator.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class TaskListCoordinator: NSObject {
  private let presenter: FolderListViewController
  
  init(presenter: FolderListViewController) {
    self.presenter = presenter
    super.init()
  }
}

extension TaskListCoordinator: Coordinatable {
  func start() {
    // vm, nav, dependencies
  }
}
