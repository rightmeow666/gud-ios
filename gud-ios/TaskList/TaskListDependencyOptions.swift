//
//  TaskListDependencyOptions.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

struct TaskListDependencyOptions {
  let networkService: GudNetworkService
  
  let taskListCacheService: TaskListDataStore
}
