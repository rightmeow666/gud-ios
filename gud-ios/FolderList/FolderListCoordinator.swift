//
//  FolderListCoordinator.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class FolderListCoordinator: NSObject {
  private let presenter: AppTabBarController
  
  private let options: FolderListDependencyOptions
  
  private var childCoordinator: FolderEditorCoordinator?
  
  init(presenter: AppTabBarController, options: FolderListDependencyOptions) {
    self.presenter = presenter
    self.options = options
    super.init()
  }
}

extension FolderListCoordinator: Coordinatable {
  func start() {
    let vc = FolderListViewController()
    let vm = FolderListViewModel(options: self.options, delegate: vc)
    vc.delegate = self
    vc.viewModel = vm
    let navController = FolderListNavigationController(rootViewController: vc)
    if self.presenter.viewControllers == nil {
      self.presenter.setViewControllers([navController], animated: true)
    } else {
      self.presenter.viewControllers?.append(navController)
    }
  }
}

extension FolderListCoordinator: FolderListViewControllerDelegate {
  func folderListViewController(_ controller: FolderListViewController, didTapAddButton button: UIBarButtonItem) {
    let options = FolderEditorDependencyOptions(networkService: GudNetworkService(), cacheService: FolderEditorDataStore(folder: nil))
    let folderEditorCoordinator = FolderEditorCoordinator(presenter: controller, options: options)
    self.childCoordinator = folderEditorCoordinator
    folderEditorCoordinator.start()
  }
  
  func folderListViewController(_ controller: FolderListViewController, didSelectFolder folder: Folder) {
    // TODO: segue to folder details
    print("segue to folder details")
  }
}
