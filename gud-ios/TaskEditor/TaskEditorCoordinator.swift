//
//  TaskEditorCoordinator.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskEditorCoordinator: NSObject {
  private let presenter: TaskListViewController
  
  private let options: TaskEditorDependencyOptions
  
  private var viewController: TaskEditorViewController?
  
  private var navigationController: TaskEditorNavigationController?
  
  init(presenter: TaskListViewController, options: TaskEditorDependencyOptions) {
    self.presenter = presenter
    self.options = options
    super.init()
  }
}

extension TaskEditorCoordinator: Coordinatable {
  func start() {
    let vc = TaskEditorViewController()
    vc.dataStore = self.options.cacheService
    vc.networkService = self.options.networkService
    vc.delegate = self
    self.options.cacheService.delegate = vc
    let navController = TaskEditorNavigationController(rootViewController: vc)

    self.viewController = vc
    self.navigationController = navController
    
    self.presenter.present(navController, animated: true, completion: nil)
  }
}

extension TaskEditorCoordinator: TaskEditorViewControllerDelegate {
  func controller(didTapCancelButton button: UIBarButtonItem) {
    self.viewController?.dismiss(animated: true, completion: nil)
  }
}
