//
//  TaskEditorCoordinator.swift
//  gud-ios
//
//  Created by sudofluff on 8/30/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskEditorCoordinator: NSObject {
  private let presenter: TaskListViewController
  
  init(presenter: TaskListViewController) {
    self.presenter = presenter
    super.init()
  }
}

extension TaskEditorCoordinator: Coordinatable {
  func start() {
    
  }
}
