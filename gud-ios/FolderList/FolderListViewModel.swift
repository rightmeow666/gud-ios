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
  
  private let folderListCacheService: FolderListDataStore
  
  private let folderListDropdownMenuCacheService: FolderListDropdownMenuDataStore
  
  weak var delegate: FolderListViewModelDelegate?
  
  func deleteSelectedFolders() {
    self.folderListCacheService.deleteSelectedFolders { (error) in
      if let err = error {
        self.delegate?.viewModel(self, didErr: err)
      } else {
        self.delegate?.shouldUpdateEditMode(self, isEditing: false)
      }
    }
  }
  
  func getFolderList() {
    self.folderListCacheService.getFolderList {
      self.folderListCacheService.observeFoldersForChanges(completion: { (change) in
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
  
  func getNumberOfMenuOptions(inSection section: Int) -> Int {
    return self.folderListDropdownMenuCacheService.numberOfOptions
  }
  
  func getTitleOfMenuOptions(atIndex index: Int) -> String? {
    return self.folderListDropdownMenuCacheService.getTitleForOption(atIndex: index)
  }
  
  func getSelectedMenuOption(atIndex index: Int) -> FolderListDropdownMenuDataStore.DataSource? {
    return self.folderListDropdownMenuCacheService.getOption(atIndex: index)
  }
  
  func getNumberOfItems(inSection section: Int) -> Int {
    return self.folderListCacheService.folders?.count ?? 0
  }
  
  func getFolder(atIndexPath indexPath: IndexPath) -> Folder? {
    return self.folderListCacheService.folders?[indexPath.item]
  }
  
  func selectFolder(atIndexPath indexPath: IndexPath) {
    guard let selectedFolder = self.folderListCacheService.folders?[indexPath.item] else { return }
    self.folderListCacheService.appendSelectedFolder(selectedFolder: selectedFolder)
  }
  
  func deselectFolder(atIndexPath indexPath: IndexPath) {
    guard let deselectedFolder = self.folderListCacheService.folders?[indexPath.item] else { return }
    self.folderListCacheService.removeDeselectedFolder(deselectedFolder: deselectedFolder)
  }
  
  init(options: FolderListDependencyOptions, delegate: FolderListViewModelDelegate) {
    self.networkService = options.networkService
    self.folderListCacheService = options.folderListCacheService
    self.folderListDropdownMenuCacheService = options.dropdownMenuCacheService
    self.delegate = delegate
    super.init()
  }
}
