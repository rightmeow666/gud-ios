//
//  FolderListViewModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/18/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class FolderListViewModel: NSObject {
  private let networkService: GudNetworkService
  
  private let cacheService: FolderListDataStore
  
  weak var delegate: FolderListViewModelDelegate?
  
  func deleteSelectedFolders() {
    self.cacheService.deleteSelectedFolders()
  }
  
  func getFolderList() {
    self.cacheService.getFolderList()
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
    self.cacheService.delegate = self
  }
}

extension FolderListViewModel: FolderListDataStoreDelegate {
  func store(didErr error: Error) {
    self.delegate?.viewModel(self, didErr: error)
  }
  
  func store(didGetFolderList list: Results<Folder>) {
    self.delegate?.viewModel(self, didGetFolderList: list)
  }
  
  func store(didUpdateFolderList list: Results<Folder>, deletedIndice: [Int], insertedIndice: [Int], updatedIndice: [Int]) {
    self.delegate?.viewModel(self, didUpdateFolderList: list, deletedIndice: deletedIndice, insertedIndice: insertedIndice, updatedIndice: updatedIndice)
  }
}
