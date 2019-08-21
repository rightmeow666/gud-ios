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
  
  init(presenter: FolderListViewController, options: FolderEditorDependencyOptions) {
    self.presenter = presenter
    self.options = options
    super.init()
  }
}

extension FolderEditorCoordinator: Coordinatable {
  func start() {
    let vc = FolderEditorViewController()
    let vm = FolderEditorViewModel(options: self.options, delegate: vc)
    vc.viewModel = vm
    vc.viewControllerDelegate = self
    let navController = FolderEditorNavigationController(rootViewController: vc)
    self.presenter.present(navController, animated: true, completion: nil)
  }
}

extension FolderEditorCoordinator: FolderEditorViewControllerDelegate {
  func folderEditorViewController(_ controller: FolderEditorViewController, didTapCommitButton button: UIBarButtonItem, updatedFolder: Folder) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  func folderEditorViewController(_ controller: FolderEditorViewController, didTapCancelButton button: UIBarButtonItem, hasUncommittedChanges: Bool) {
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
