//
//  TaskListDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class TaskListDataStore: BaseCacheService {
  var realmNotificationToken: NotificationToken?
  
  var folder: Folder
  
  var tasks: Results<Task>?
  
  init(selectedFolder: Folder) {
    self.folder = selectedFolder
    super.init()
  }
  
  func getTaskList(completion: (() -> Void)? = nil) {
    self.tasks = folder.tasks.sorted(byKeyPath: "createdAt", ascending: true)
    completion?()
  }
  
  func removeTask(atIndex index: Int) throws {
    guard let t = self.tasks?[index] else {
      throw DBException.logicalError(message: "Index is out of bound at index: \(index)")
    }
    try t.delete()
  }
  
  func toggleCompletion(atIndex index: Int, isCompleted: Bool) throws {
    guard let t = self.tasks?[index] else {
      throw DBException.logicalError(message: "Index is out of bound at index: \(index)")
    }
    try t.save {
      t.isCompleted = isCompleted
    }
  }
  
  func observeTasksForChanges(completion: @escaping (RealmCollectionChange<Results<Task>>) -> Void) {
    self.realmNotificationToken = self.tasks?.observe({ (changes) in
      completion(changes)
    })
  }
}
