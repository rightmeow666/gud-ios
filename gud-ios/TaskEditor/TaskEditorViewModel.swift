//
//  TaskEditorViewModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/30/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol TaskEditorViewModelDelegate: NSObjectProtocol {
  func viewModel(_ vm: TaskEditorViewModel, didErr error: Error)
  
  func didCommitChanges(_ vm: TaskEditorViewModel, withMessage message: String)
}

class TaskEditorViewModel: NSObject {
  private var networkSerivce: GudNetworkService
  
  private var store: TaskEditorDataStore
  
  weak var delegate: TaskEditorViewModelDelegate?
  
  var isModified: Bool {
    return self.store.isModified
  }
  
  init(options: TaskEditorDependencyOptions, delegate: TaskEditorViewModelDelegate) {
    self.networkSerivce = options.networkService
    self.store = options.cacheService
    self.delegate = delegate
  }
  
  func numberOfRows(inSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections() -> Int {
    return 1
  }
  
  func commitChanges() {
    self.store.commitChanges { (error) in
      if let err = error {
        self.delegate?.viewModel(self, didErr: err)
      } else {
        self.delegate?.didCommitChanges(self, withMessage: "Changes committed")
      }
    }
  }
  
  func getTask() -> Task {
    return self.store.task
  }
  
  func pushChanges() {
    // TODO: Push new changes to remote
    print("Push new changes to remote")
  }
  
  func pullChanges() {
    // TODO: Pull new changes from remote
    print("Pull button tapped")
  }
  
  func titleForHeader(inSection section: Int) -> String? {
    switch section {
    case 0:
      return "title".uppercased()
    default:
      return nil
    }
  }
  
  func updateTask(withNewTitle title: String) {
    self.store.updateTaskTitle(title: title)
  }
}
