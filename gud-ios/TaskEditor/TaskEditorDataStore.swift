//
//  TaskEditorDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol TaskEditorDataStoreDelegate: NSObject {
  func store(isModified: Bool)
}

class TaskEditorDataStore: NSObject {
  weak var delegate: TaskEditorDataStoreDelegate?
  
  private var isModified: Bool {
    return self.initialTask.title != self.task.title
  }
  
  private var initialTask: Task
  
  var task: Task
  
  init(task: Task?) {
    if let unwrappedTask = task {
      self.task = unwrappedTask
      self.initialTask = unwrappedTask
    } else {
      let newTask = Task(title: "")
      self.task = newTask
      self.initialTask = newTask
    }
    super.init()
  }
}
