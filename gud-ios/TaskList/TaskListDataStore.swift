//
//  TaskListDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class TaskListDataStore: BaseCacheService {
  var folder: Folder
  
  init(selectedFolder: Folder) {
    self.folder = selectedFolder
    super.init()
  }
}
