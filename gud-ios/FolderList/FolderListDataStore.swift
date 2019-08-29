//
//  FolderListDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class FolderListDataStore: BaseCacheService {
  var realmNotificationToken: NotificationToken?
  
  var folders: Results<Folder>?
  
  /// Array of unique selected folders
  var selectedFolders: [Folder] = []
  
  func appendSelectedFolder(selectedFolder folder: Folder) {
    self.selectedFolders.append(folder)
  }
  
  func removeDeselectedFolder(deselectedFolder folder: Folder) {
    self.selectedFolders.removeAll(where: { $0.folderId == folder.folderId })
  }
  
  func deleteSelectedFolders(completion: (Result<String, Error>) -> Void) {
    do {
      try Folder.deleteAll(folders: self.selectedFolders)
      completion(.success("Folder(s) deleted"))
    } catch let err {
      completion(.failure(err))
    }
  }
  
  func observeFoldersForChanges(completion: @escaping (RealmCollectionChange<Results<Folder>>) -> Void) {
    self.realmNotificationToken = self.folders?.observe({ (changes) in
      completion(changes)
    })
  }
  
  func getFolderList(completion: (() -> Void)? = nil) {
    self.folders = Folder.all
    completion?()
  }
  
  override init() {
    super.init()
  }
}
