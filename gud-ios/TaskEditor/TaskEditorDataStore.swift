//
//  TaskEditorDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 8/30/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class TaskEditorDataStore: BaseCacheService {
  var isModified: Bool {
    if self.initialTask.title != self.task.title || self.initialTask.isCompleted != self.task.isCompleted {
      return true
    } else {
      return false
    }
  }
  
  var task: Task
  
  private var initialTask: Task
  
  private var parentFolder: Folder
  
  func updateTaskTitle(title: String) {
    self.task.title = title
  }
  
  func commitChanges(completion: (Error?) -> Void) {
    do {
      guard self.isModified else {
        throw DataStoreError.customError(message: "No changes to commit")
      }
      try self.task.save {
        self.initialTask = self.task
        self.parentFolder.tasks.append(self.task)
      }
      completion(nil)
    } catch let err {
      completion(err)
    }
  }
  
  init(task: Task?, parentFolder: Folder) {
    self.parentFolder = parentFolder
    if let t = task {
      self.task = t
      self.initialTask = t
    } else {
      self.task = Task.create { () -> Task in
        let t = Task()
        t.folderId = parentFolder.id
        return t
      }
      self.initialTask = Task.create({ () -> Task in
        let t = Task()
        t.folderId = parentFolder.id
        return t
      })
    }
    super.init()
  }
}
