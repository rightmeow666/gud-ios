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
  
  var tasks: List<Task>
  
  init(selectedFolder: Folder) {
    self.folder = selectedFolder
    self.tasks = folder.tasks
    super.init()
  }
}
