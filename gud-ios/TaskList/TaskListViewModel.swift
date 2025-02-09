//
//  TaskListViewModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol TaskListViewModelDelegate: NSObjectProtocol {
  func didGetTaskList(_ vm: TaskListViewModel)
  
  func viewModel(_ vm: TaskListViewModel, deletedIndice: [Int], insertedIndice: [Int], modifiedIndice: [Int])
  
  func viewModel(_ vm: TaskListViewModel, didErr error: Error)
}

class TaskListViewModel: NSObject {
  private let networkService: GudNetworkService
  
  private let taskListCacheService: TaskListDataStore
  
  weak var delegate: TaskListViewModelDelegate?
  
  var viewControllerTitle: String {
    return self.taskListCacheService.folder.title
  }
  
  func getNumberOfItems(inSection section: Int) -> Int {
    return self.taskListCacheService.folder.tasks.count
  }
  
  func getNumberOfSections() -> Int {
    return 1
  }
  
  func getTaskList() {
    self.taskListCacheService.getTaskList {
      self.taskListCacheService.observeTasksForChanges(completion: { (change) in
        switch change {
        case .initial:
          self.delegate?.didGetTaskList(self)
        case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
          self.delegate?.viewModel(self, deletedIndice: deletions, insertedIndice: insertions, modifiedIndice: modifications)
        case .error(let err):
          self.delegate?.viewModel(self, didErr: err)
        }
      })
    }
  }
  
  func getTask(atIndex index: Int) -> Task? {
    return self.taskListCacheService.tasks?[index]
  }
  
  func searchTasks(byTitle title: String) -> [[SearchResult]] {
    let predicate = NSPredicate(format: "title contains[cd] %@", title)
    let matches = Task.findAll(byPredicate: predicate, sortedBy: "createdAt", ascending: false)
    var searchResults: [SearchResult] = []
    for m in matches {
      let sr = SearchResult(id: m.id, title: m.title, subtitle: m.createdAt?.toString ?? nil)
      searchResults.append(sr)
    }
    return [searchResults]
  }
  
  func isTaskCompleted(atIndex index: Int) -> Bool {
    guard let t = self.getTask(atIndex: index) else { return false }
    return t.isCompleted
  }
  
  func removeTask(atIndex index: Int) {
    do {
      try self.taskListCacheService.removeTask(atIndex: index)
    } catch let err {
      self.delegate?.viewModel(self, didErr: err)
    }
  }
  
  func toggleCompletion(atIndex index: Int, isCompleted: Bool) {
    do {
      try self.taskListCacheService.toggleCompletion(atIndex: index, isCompleted: isCompleted)
    } catch let err {
      self.delegate?.viewModel(self, didErr: err)
    }
  }
  
  init(options: TaskListDependencyOptions, delegate: TaskListViewModelDelegate) {
    self.networkService = options.networkService
    self.taskListCacheService = options.taskListCacheService
    self.delegate = delegate
  }
}
