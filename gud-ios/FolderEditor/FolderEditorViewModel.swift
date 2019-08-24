//
//  FolderEditorViewModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/21/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol FolderEditorViewModelDelegate: NSObjectProtocol {
  func viewModel(_ vm: FolderEditorViewModel, didErr error: Error)
  
  func didCommitChanges(_ vm: FolderEditorViewModel, withMessage message: String)
}

class FolderEditorViewModel: NSObject {
  private var networkService: GudNetworkService
  
  private var store: FolderEditorDataStore
  
  weak var delegate: FolderEditorViewModelDelegate?
  
  var isModified: Bool {
    return self.store.isModified
  }
  
  init(options: FolderEditorDependencyOptions, delegate: FolderEditorViewModelDelegate) {
    self.networkService = options.networkService
    self.store = options.cacheService
    self.delegate = delegate
  }
  
  func numberOfRows(inSection section: Int) -> Int {
    return 1
  }
  
  func commitChanges() {
    self.store.commitChanges { (result) in
      switch result {
      case .failure(let err):
        self.delegate?.viewModel(self, didErr: err)
      case .success(let successMessage):
        print(successMessage)
        self.delegate?.didCommitChanges(self, withMessage: successMessage)
      }
    }
  }
  
  func getFolder() -> Folder {
    return self.store.folder
  }
  
  func titleForHeader(inSection section: Int) -> String? {
    switch section {
    case 0:
      return "title".uppercased()
    default:
      return nil
    }
  }
  
  func pushChanges() {
    // TODO: Push new changes to remote
    print("Push new changes to remote")
  }
  
  func pullChanges() {
    // TODO: Pull new changes from remote
    print("Pull button tapped")
  }
  
  func updateFolder(withNewTitle title: String) {
    self.store.updateFolderTitle(title: title)
  }
}
