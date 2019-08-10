//
//  TaskEditorDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class TaskEditorDataStore: BaseCacheService {  
  weak var delegate: TaskEditorDataStoreDelegate?
  
  private var isModified: Bool {
    return self.initialTask.title != self.task.title
  }
  
  private var initialTask: Task
  
  var task: Task
  
  func updateTaskTitle(title: String) {
    self.task.title = title
  }
  
  func commitChanges() {
    do {
      if self.isModified {
        try self.task.save()
      }
    } catch let err {
      self.delegate?.store(didErr: err)
    }
  }
  
  init(task: Task?) {
    if let unwrappedTask = task {
      self.task = unwrappedTask
      self.initialTask = unwrappedTask
    } else {
      self.task = Task(title: "")
      self.initialTask = Task(title: "")
    }
    super.init()
  }
}
