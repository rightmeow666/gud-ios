//
//  TaskListViewModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol TaskListViewModelDelegate: NSObjectProtocol {
}

class TaskListViewModel: NSObject {
  private let networkService: GudNetworkService
  
  private let taskListCacheService: TaskListDataStore
  
  weak var delegate: TaskListViewModelDelegate?
  
  var viewControllerTitle: String {
    return self.taskListCacheService.folder.title
  }
  
  init(options: TaskListDependencyOptions, delegate: TaskListViewModelDelegate) {
    self.networkService = options.networkService
    self.taskListCacheService = options.taskListCacheService
    self.delegate = delegate
  }
}
