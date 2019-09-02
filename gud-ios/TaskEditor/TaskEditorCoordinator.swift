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
  
  private let parentFolder: Folder
  
  private let selectedTask: Task?
  
  init(presenter: TaskListViewController, parentFolder: Folder, selectedTask: Task?) {
    self.presenter = presenter
    self.parentFolder = parentFolder
    self.selectedTask = selectedTask
    super.init()
  }
}

extension TaskEditorCoordinator: Coordinatable {
  func start() {
    let vc = TaskEditorViewController()
    let store = TaskEditorDataStore(task: self.selectedTask, parentFolder: self.parentFolder)
    let options = TaskEditorDependencyOptions(networkService: GudNetworkService(), cacheService: store)
    let vm = TaskEditorViewModel(options: options, delegate: vc)
    vc.viewModel = vm
    vc.delegate = self
    let navController = TaskEditorNavigationController(rootViewController: vc)
    self.presenter.present(navController, animated: true, completion: nil)
  }
}

extension TaskEditorCoordinator: TaskEditorViewControllerDelegate {
  func taskEditorViewController(_ controller: TaskEditorViewController, didTapCancelButton button: UIBarButtonItem, hasUncommittedChanges: Bool) {
    switch hasUncommittedChanges {
    case true:
      let alertController = UIAlertController(title: "You have uncommitted changes", message: "Are you sure you want to exit editor", preferredStyle: .alert)
      let exitAction = UIAlertAction(title: "Exit", style: .destructive) { (action) in
        controller.dismiss(animated: true, completion: nil)
      }
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alertController.addAction(exitAction)
      alertController.addAction(cancelAction)
      controller.present(alertController, animated: true, completion: nil)
    case false:
      controller.dismiss(animated: true, completion: nil)
    }
  }
}
