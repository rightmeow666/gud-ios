//
//  TaskEditorViewModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/30/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class TaskEditorViewModel: NSObject {
  private var networkSerivce: GudNetworkService
  
  private var store: TaskEditorDataStore
  
  init(options: TaskEditorDependencyOptions) {
    self.networkSerivce = options.networkService
    self.store = options.cacheService
  }
}
