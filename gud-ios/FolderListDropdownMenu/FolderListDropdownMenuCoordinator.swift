//
//  FolderListDropdownMenuCoordinator.swift
//  gud-ios
//
//  Created by sudofluff on 8/27/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class FolderListDropdownMenuCoordinator: NSObject {
  private weak var presenter: FolderListViewController?
  
  private let sourceView: DropdownMenuSourceView
  
  private let preferredContentSize: CGSize
  
  init(presenter: FolderListViewController, sourceView: DropdownMenuSourceView, preferredContentSize: CGSize) {
    self.presenter = presenter
    self.sourceView = sourceView
    self.preferredContentSize = preferredContentSize
    super.init()
  }
}

extension FolderListDropdownMenuCoordinator: Coordinatable {
  func start() {
    let vc = DropdownMenuViewController()
    vc.modalPresentationStyle = .popover
    vc.preferredContentSize = self.preferredContentSize
    vc.modalTransitionStyle = .crossDissolve
    vc.popoverPresentationController?.delegate = self.presenter
    switch self.sourceView {
    case .UIBarButtonItem(item: let item):
      vc.popoverPresentationController?.barButtonItem = item
    case .UIButton(button: let button):
      vc.popoverPresentationController?.sourceView = button
      vc.popoverPresentationController?.sourceRect = button.bounds
    }
    vc.popoverPresentationController?.permittedArrowDirections = [.up]
    vc.delegate = self.presenter
    vc.dataSource = self.presenter
    self.presenter?.present(vc, animated: true, completion: nil)
  }
}
