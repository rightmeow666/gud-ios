//
//  FolderEditorViewModelDelegate.swift
//  gud-ios
//
//  Created by sudofluff on 8/21/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol FolderEditorViewModelDelegate: NSObjectProtocol {
  func viewModel(_ vm: FolderEditorViewModel, didErr error: Error)
  
  func viewModel(_ vm: FolderEditorViewModel, didCommitChangesToFolder folder: Folder)
}
