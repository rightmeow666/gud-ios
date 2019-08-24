//
//  FolderListViewModelDelegate.swift
//  gud-ios
//
//  Created by sudofluff on 8/18/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

protocol FolderListViewModelDelegate: NSObjectProtocol {
  func shouldUpdateEditMode(_ vm: FolderListViewModel, isEditing: Bool)
  
  func didGetFolderList(_ vm: FolderListViewModel)
  
  func viewModel(_ vm: FolderListViewModel, didErr error: Error)
    
  func viewModel(_ vm: FolderListViewModel, deletedIndice: [Int], insertedIndice: [Int], modifiedIndice: [Int])
}
