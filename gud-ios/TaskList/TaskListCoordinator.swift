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
  
  private let presentingNavController: FolderListNavigationController
  
  private let selectedFolder: Folder
  
  init(presenter: FolderListViewController, presentingNavController: FolderListNavigationController, selectedFolder: Folder) {
    self.presenter = presenter
    self.presentingNavController = presentingNavController
    self.selectedFolder = selectedFolder
    super.init()
  }
}

extension TaskListCoordinator: Coordinatable {
  func start() {
    // vm, nav, dependencies
    let vc = TaskListViewController()
    let options = TaskListDependencyOptions(networkService: GudNetworkService(), taskListCacheService: TaskListDataStore(selectedFolder: self.selectedFolder))
    let vm = TaskListViewModel(options: options, delegate: vc)
    vc.viewModel = vm
    self.presentingNavController.pushViewController(vc, animated: true)
  }
}
