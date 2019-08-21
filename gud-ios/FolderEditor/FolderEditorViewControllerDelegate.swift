//
//  FolderEditorViewControllerDelegate.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol FolderEditorViewControllerDelegate: NSObjectProtocol {  
  func folderEditorViewController(_ controller: FolderEditorViewController, didTapCancelButton button: UIBarButtonItem, hasUncommittedChanges: Bool)
  
  func folderEditorViewController(_ controller: FolderEditorViewController, didTapCommitButton button: UIBarButtonItem, updatedFolder: Folder)
}
