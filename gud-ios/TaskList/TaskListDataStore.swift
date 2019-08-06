//
//  TaskListDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class TaskListDataStore: BaseCacheService {
  typealias CompletionBlock = () -> Void
  
  var pendingTasks: [Task] = {
    let tempTask = Task(taskId: "oaisj", title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", createdAt: Date(), updatedAt: Date())
    return [tempTask]
  }()
  
  /// Array of unique selected tasks
  var selectedTasks: [Task] = []
  
  func appendSelectedTask(selectedTask task: Task) {
    self.selectedTasks.append(task)
  }
  
  func removeDeselectedTask(deselectedTask task: Task) {
    self.selectedTasks.removeAll(where: { $0.taskId == task.taskId })
  }
  
  func deleteSelectedTasks(block: CompletionBlock) {
    self.selectedTasks.forEach({ $0.delete() })
    block()
  }
}
