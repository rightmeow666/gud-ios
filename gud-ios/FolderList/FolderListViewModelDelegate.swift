//
//  FolderListViewModelDelegate.swift
//  gud-ios
//
//  Created by sudofluff on 8/18/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

protocol FolderListViewModelDelegate: NSObjectProtocol {
  func viewModel(_ vm: FolderListViewModel, didErr error: Error)
  
  func viewModel(_ vm: FolderListViewModel, didGetFolderList list: Results<Folder>)
  
  func viewModel(_ vm: FolderListViewModel, didUpdateFolderList list: Results<Folder>, deletedIndice: [Int], insertedIndice: [Int], updatedIndice: [Int])
}
