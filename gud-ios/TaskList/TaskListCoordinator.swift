//
//  TaskListCoordinator.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskListCoordinator: NSObject {
  private let presenter: AppTabBarController
  
  private let options: TaskListDependencyOptions
  
  private var viewController: TaskListViewController?
  
  private var navigationController: TaskListNavigationController?
  
  private var taskEditorCoordinator: TaskEditorCoordinator?
  
  init(presenter: AppTabBarController, options: TaskListDependencyOptions) {
    self.presenter = presenter
    self.options = options
    super.init()
  }
}

extension TaskListCoordinator: Coordinatable {
  func start() {
    let vc = TaskListViewController()
    vc.networkService = self.options.networkService
    vc.dataStore = self.options.cacheService
    let navController = TaskListNavigationController(rootViewController: vc)
    
    vc.delegate = self
    self.viewController = vc
    self.navigationController = navController
    
    if self.presenter.viewControllers == nil {
      self.presenter.setViewControllers([navController], animated: true)
    } else {
      self.presenter.viewControllers?.append(navController)
    }
  }
}

extension TaskListCoordinator: TaskListViewControllerDelegate {
  func controller(didTapAddButton button: UIBarButtonItem) {
    guard let vc = self.viewController else { return }
    let options = TaskEditorDependencyOptions(networkService: GudNetworkService(), cacheService: TaskEditorDataStore(task: nil))
    self.taskEditorCoordinator = TaskEditorCoordinator(presenter: vc, options: options)
    self.taskEditorCoordinator?.start()
  }
  
  func controller(didSelectTask task: Task) {
    // TODO: segues to task details
    print("seguing to task details")
  }
}
