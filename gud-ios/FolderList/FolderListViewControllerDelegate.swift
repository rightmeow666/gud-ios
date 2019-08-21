//
//  FolderListViewControllerDelegate.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol FolderListViewControllerDelegate: NSObjectProtocol {
  func folderListViewController(_ controller: FolderListViewController, didTapAddButton button: UIBarButtonItem)
  
  func folderListViewController(_ controller: FolderListViewController, didSelectFolder folder: Folder)
}
