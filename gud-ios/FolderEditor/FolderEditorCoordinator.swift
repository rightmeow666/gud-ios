//
//  FolderEditorCoordinator.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class FolderEditorCoordinator: NSObject {
  private let presenter: FolderListViewController
  
  private let options: FolderEditorDependencyOptions
  
  private var viewController: FolderEditorViewController?
  
  private var navigationController: FolderEditorNavigationController?
  
  init(presenter: FolderListViewController, options: FolderEditorDependencyOptions) {
    self.presenter = presenter
    self.options = options
    super.init()
  }
}

extension FolderEditorCoordinator: Coordinatable {
  func start() {
    let vc = FolderEditorViewController()
    vc.dataStore = self.options.cacheService
    vc.networkService = self.options.networkService
    vc.delegate = self
    self.options.cacheService.delegate = vc
    let navController = FolderEditorNavigationController(rootViewController: vc)

    self.viewController = vc
    self.navigationController = navController
    
    self.presenter.present(navController, animated: true, completion: nil)
  }
}

extension FolderEditorCoordinator: FolderEditorViewControllerDelegate {
  func controller(didTapCancelButton button: UIBarButtonItem) {
    self.viewController?.dismiss(animated: true, completion: nil)
  }
}
