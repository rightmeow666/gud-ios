//
//  TaskListCoordinator.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskListCoordinator: NSObject {
  private let presenter: FolderListNavigationController
  
  private let options: TaskListDependencyOptions
  
  private var editorCoordinator: TaskEditorCoordinator?
  
  init(presenter: FolderListNavigationController, options: TaskListDependencyOptions) {
    self.presenter = presenter
    self.options = options
    super.init()
  }
}

extension TaskListCoordinator: Coordinatable {
  func start() {
    let vc = TaskListViewController()
    let vm = TaskListViewModel(options: self.options, delegate: vc)
    vc.viewModel = vm
    vc.delegate = self
    self.presenter.pushViewController(vc, animated: true)
  }
}

extension TaskListCoordinator: TaskListViewControllerDelegate {
  func taskListViewController(_ controller: TaskListViewController, didTapAddButton button: UIBarButtonItem) {
    let coordinator = TaskEditorCoordinator(presenter: controller, parentFolder: self.options.taskListCacheService.folder, selectedTask: nil)
    self.editorCoordinator = coordinator
    coordinator.start()
  }
}
