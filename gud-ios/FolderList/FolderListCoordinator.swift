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
  
  private var viewController: FolderListViewController?
  
  private var navigationController: FolderListNavigationController?
  
  private var folderEditorCoordinator: FolderEditorCoordinator?
  
  init(presenter: AppTabBarController, options: FolderListDependencyOptions) {
    self.presenter = presenter
    self.options = options
    super.init()
  }
}

extension FolderListCoordinator: Coordinatable {
  func start() {
    let vc = FolderListViewController()
    vc.networkService = self.options.networkService
    vc.dataStore = self.options.cacheService
    vc.dataStore?.delegate = vc
    let navController = FolderListNavigationController(rootViewController: vc)
    
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

extension FolderListCoordinator: FolderListViewControllerDelegate {
  func controller(didTapAddButton button: UIBarButtonItem) {
    guard let vc = self.viewController else { return }
    let options = FolderEditorDependencyOptions(networkService: GudNetworkService(), cacheService: FolderEditorDataStore(folder: nil))
    self.folderEditorCoordinator = FolderEditorCoordinator(presenter: vc, options: options)
    self.folderEditorCoordinator?.start()
  }
  
  func controller(didSelectFolder folder: Folder) {
    // TODO: segues to folder details
    print("seguing to folder details")
  }
}
