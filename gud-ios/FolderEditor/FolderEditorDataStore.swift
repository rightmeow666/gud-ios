//
//  FolderEditorDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol FolderEditorDataStoreDelegate: NSObjectProtocol {
  func store(didErr error: DBException)
  
  func store(didCommitChangesToFolder folder: Folder)
}

class FolderEditorDataStore: BaseCacheService {
  var isModified: Bool {
    return self.initialFolder.title != self.folder.title
  }
  
  private var initialFolder: Folder
  
  var folder: Folder
  
  func updateFolderTitle(title: String) {
    self.folder.title = title
  }
  
  func commitChanges(completion: (Error?) -> Void) {
    do {
      guard self.isModified else {
        throw DBException.logical("No changes to commit")
      }
      try self.folder.save({
        self.initialFolder = self.folder
      })
      completion(nil)
    } catch let err {
      completion(err)
    }
  }
  
  init(folder: Folder?) {
    if let unwrappedFolder = folder {
      self.folder = unwrappedFolder
      self.initialFolder = unwrappedFolder
    } else {
      self.folder = Folder.create({ () -> Folder in
        return Folder()
      })
      self.initialFolder = Folder.create({ () -> Folder in
        return Folder()
      })
    }
    super.init()
  }
}
