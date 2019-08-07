//
//  Task.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class Task: Object {
  @objc dynamic var taskId: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var createdAt: NSDate = NSDate()
  @objc dynamic var updatedAt: NSDate = NSDate()
  
  func delete() {
  }
  
  override static func primaryKey() -> String? {
    return "taskId"
  }
  
  convenience init(title: String) {
    self.init()
    self.title = title
  }
}
