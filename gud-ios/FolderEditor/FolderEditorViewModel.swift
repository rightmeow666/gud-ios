//
//  FolderEditorViewModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/21/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

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
    if self.store.isModified {
      self.store.commitChanges()
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

extension FolderEditorViewModel: FolderEditorDataStoreDelegate {
  func store(didErr error: Error) {
    self.delegate?.viewModel(self, didErr: error)
  }
  
  func store(didCommitChangesToFolder folder: Folder) {
    self.delegate?.viewModel(self, didCommitChangesToFolder: folder)
  }
}
