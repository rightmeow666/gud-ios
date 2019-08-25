//
//  AppCoordinator.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject {
  private let options: AppDependencyOptions
  
  private let presenter: UIWindow
  
  private var childCoordinators: [Coordinatable]
  
  init(options: AppDependencyOptions, presenter: UIWindow) {
    self.options = options
    self.childCoordinators = []
    self.presenter = presenter
    super.init()
  }
}

extension AppCoordinator: Coordinatable {
  func start() {
    // app tab bar
    let appTabBarController = AppTabBarController()
    let appTabBarViewModel = AppViewModel(dependencyOptions: self.options, delegate: appTabBarController)
    appTabBarController.viewModel = appTabBarViewModel
    appTabBarController.viewControllerDelegate = self
    self.presenter.rootViewController = appTabBarController
    
    // folder list
    let options = FolderListDependencyOptions(networkService: GudNetworkService(), folderListCacheService: FolderListDataStore(), dropdownMenuCacheService: FolderListDropdownMenuDataStore())
    let folderListCoordinator = FolderListCoordinator(presenter: appTabBarController, options: options)
    self.childCoordinators.append(folderListCoordinator)
    
    // start
    self.childCoordinators.forEach({ $0.start() })
  }
}

extension AppCoordinator: AppTabBarControllerDelegate {
}
