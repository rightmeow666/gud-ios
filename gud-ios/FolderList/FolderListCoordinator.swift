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
  
  private var editorCoordinator: FolderEditorCoordinator?
  
  private var dropdownMenuCoordinator: FolderListDropdownMenuCoordinator?
  
  private var taskListCoordinator: TaskListCoordinator?
  
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
  func folderListViewController(_ controller: FolderListViewController, didSelectAddOptionOnSourceView sourceView: UIBarButtonItem) {
    let options = FolderEditorDependencyOptions(networkService: GudNetworkService(), cacheService: FolderEditorDataStore(folder: nil))
    let folderEditorCoordinator = FolderEditorCoordinator(presenter: controller, options: options)
    self.editorCoordinator = folderEditorCoordinator
    folderEditorCoordinator.start()
  }
  
  func folderListViewController(_ controller: FolderListViewController, didSelectFolder folder: Folder) {
    guard let navController = controller.navigationController as? FolderListNavigationController else { return }
    let options = TaskListDependencyOptions(networkService: GudNetworkService(), taskListCacheService: TaskListDataStore(selectedFolder: folder))
    let coordinator = TaskListCoordinator(presenter: navController, options: options)
    self.taskListCoordinator = coordinator
    coordinator.start()
  }
  
  func folderListViewController(_ controller: FolderListViewController, didTapMoreButton button: UIBarButtonItem) {
    let sourceView = DropdownMenuSourceView.UIBarButtonItem(item: button)
    let coordinator = FolderListDropdownMenuCoordinator(presenter: controller, sourceView: sourceView, preferredContentSize: CGSize(width: controller.view.frame.width / 2, height: 88))
    self.dropdownMenuCoordinator = coordinator
    coordinator.start()
  }
}
