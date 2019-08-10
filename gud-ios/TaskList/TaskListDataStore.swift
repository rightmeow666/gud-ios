//
//  TaskListDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class TaskListDataStore: BaseCacheService {
  typealias CompletionBlock = () -> Void
  
  weak var delegate: TaskListDataStoreDelegate?
  
  var realmNotificationToken: NotificationToken?
  
  var tasks: Results<Task>? {
    didSet {
      self.observeTasksForChanges()
    }
  }
  
  /// Array of unique selected tasks
  var selectedTasks: [Task] = []
  
  func appendSelectedTask(selectedTask task: Task) {
    self.selectedTasks.append(task)
  }
  
  func removeDeselectedTask(deselectedTask task: Task) {
    self.selectedTasks.removeAll(where: { $0.taskId == task.taskId })
  }
  
  func deleteSelectedTasks() {
    do {
      try Task.deleteAll(tasks: self.selectedTasks)
    } catch let err {
      self.delegate?.store(didErr: err)
    }
  }
  
  func observeTasksForChanges() {
    self.realmNotificationToken = self.tasks?.observe({ [weak self] (changes) in
      guard let strongSelf = self else { return }
      guard let list = strongSelf.tasks else { return }
      switch changes {
      case .initial:
        self?.delegate?.store(didGetTaskList: list)
      case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
        self?.delegate?.store(didUpdateTaskList: list, deletedIndice: deletions, insertedIndice: insertions, updatedIndice: modifications)
        break
      case .error(let err):
        self?.delegate?.store(didErr: err)
      }
    })
  }
  
  func getTaskList() {
    self.tasks = Task.all
  }
  
  override init() {
    super.init()
  }
}
