//
//  FolderListDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class FolderListDataStore: BaseCacheService {
  weak var delegate: FolderListDataStoreDelegate?
  
  var realmNotificationToken: NotificationToken?
  
  var folders: Results<Folder>? {
    didSet {
      self.observeFoldersForChanges()
    }
  }
  
  /// Array of unique selected folders
  var selectedFolders: [Folder] = []
  
  func appendSelectedFolder(selectedFolder folder: Folder) {
    self.selectedFolders.append(folder)
  }
  
  func removeDeselectedFolder(deselectedFolder folder: Folder) {
    self.selectedFolders.removeAll(where: { $0.folderId == folder.folderId })
  }
  
  func deleteSelectedFolders() {
    do {
      try Folder.deleteAll(folders: self.selectedFolders)
    } catch let err {
      self.delegate?.store(didErr: err)
    }
  }
  
  func observeFoldersForChanges() {
    self.realmNotificationToken = self.folders?.observe({ [weak self] (changes) in
      guard let strongSelf = self else { return }
      guard let list = strongSelf.folders else { return }
      switch changes {
      case .initial:
        self?.delegate?.store(didGetFolderList: list)
      case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
        self?.delegate?.store(didUpdateFolderList: list, deletedIndice: deletions, insertedIndice: insertions, updatedIndice: modifications)
        break
      case .error(let err):
        self?.delegate?.store(didErr: err)
      }
    })
  }
  
  func getFolderList() {
    self.folders = Folder.all
  }
  
  override init() {
    super.init()
  }
}
