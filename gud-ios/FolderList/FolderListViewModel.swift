//
//  FolderListViewModel.swift
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

class FolderListViewModel: NSObject {
  private let networkService: GudNetworkService
  
  private let cacheService: FolderListDataStore
  
  weak var delegate: FolderListViewModelDelegate?
  
  func deleteSelectedFolders() {
    self.cacheService.deleteSelectedFolders { (result) in
      switch result {
      case .failure(let err):
        self.delegate?.viewModel(self, didErr: err)
      case .success(let successMsg):
        print(successMsg)
        self.delegate?.shouldUpdateEditMode(self, isEditing: false)
      }
    }
  }
  
  func getFolderList() {
    self.cacheService.getFolderList {
      self.cacheService.observeFoldersForChanges(completion: { (change) in
        switch change {
        case .initial:
          self.delegate?.didGetFolderList(self)
        case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
          self.delegate?.viewModel(self, deletedIndice: deletions, insertedIndice: insertions, modifiedIndice: modifications)
        case .error(let err):
          self.delegate?.viewModel(self, didErr: err)
        }
      })
    }
  }
  
  func getNumberOfItems(inSection section: Int) -> Int {
    return self.cacheService.folders?.count ?? 0
  }
  
  func getFolder(atIndexPath indexPath: IndexPath) -> Folder? {
    return self.cacheService.folders?[indexPath.item]
  }
  
  func selectFolder(atIndexPath indexPath: IndexPath) {
    guard let selectedFolder = self.cacheService.folders?[indexPath.item] else { return }
    self.cacheService.appendSelectedFolder(selectedFolder: selectedFolder)
  }
  
  func deselectFolder(atIndexPath indexPath: IndexPath) {
    guard let deselectedFolder = self.cacheService.folders?[indexPath.item] else { return }
    self.cacheService.removeDeselectedFolder(deselectedFolder: deselectedFolder)
  }
  
  init(options: FolderListDependencyOptions, delegate: FolderListViewModelDelegate) {
    self.networkService = options.networkService
    self.cacheService = options.cacheService
    self.delegate = delegate
    super.init()
  }
}
