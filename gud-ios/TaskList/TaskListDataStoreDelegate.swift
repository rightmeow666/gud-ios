//
//  TaskListDataStoreDelegate.swift
//  gud-ios
//
//  Created by sudofluff on 8/10/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

protocol TaskListDataStoreDelegate: NSObjectProtocol {
  func store(didErr error: Error)
  
  func store(didGetTaskList list: Results<Task>)
  
  func store(didUpdateTaskList list: Results<Task>, deletedIndice: [Int], insertedIndice: [Int], updatedIndice: [Int])
}
