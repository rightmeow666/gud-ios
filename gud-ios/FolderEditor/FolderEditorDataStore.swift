//
//  FolderEditorDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class FolderEditorDataStore: BaseCacheService {
  weak var delegate: FolderEditorDataStoreDelegate?
  
  var isModified: Bool {
    return self.initialFolder.title != self.folder.title
  }
  
  private var initialFolder: Folder
  
  var folder: Folder
  
  func updateFolderTitle(title: String) {
    self.folder.title = title
  }
  
  func commitChanges() {
    do {
      try self.folder.save()
      self.delegate?.store(didCommitChangesToFolder: self.folder)
    } catch let err {
      self.delegate?.store(didErr: err)
    }
  }
  
  init(folder: Folder?) {
    if let unwrappedFolder = folder {
      self.folder = unwrappedFolder
      self.initialFolder = unwrappedFolder
    } else {
      self.folder = Folder(title: "")
      self.initialFolder = Folder(title: "")
    }
    super.init()
  }
}
