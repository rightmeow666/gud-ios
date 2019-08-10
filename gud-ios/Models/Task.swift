//
//  Task.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class Task: BaseModel {
  @objc dynamic var taskId: String = ""
  
  @objc dynamic var title: String = ""
  
  @objc dynamic var createdAt: NSDate = NSDate()
  
  @objc dynamic var updatedAt: NSDate = NSDate()
  
  static let TITLE_MAX_LEGNTH: Int = 128
  
  static let TITLE_MIN_LENGTH: Int = 3
  
  static func isTitleValid(title: String) -> Bool {
    let c = title.count
    if c >= Task.TITLE_MIN_LENGTH && c <= Task.TITLE_MAX_LEGNTH {
      return true
    } else {
      return false
    }
  }
  
  static var all: Results<Task> {
    return RealmManager.shared.db.objects(Task.self)
  }
  
  static func deleteAll(tasks: [Task]) throws {
    do {
      try RealmManager.shared.db.write {
        RealmManager.shared.db.delete(tasks)
      }
    } catch let err {
      throw PersistenceError.deleteError(error: err)
    }
  }
  
  func delete() throws {
    do {
      try RealmManager.shared.db.write {
        RealmManager.shared.db.delete(self)
      }
    } catch let err {
      throw PersistenceError.deleteError(error: err)
    }
  }
  
  func save() throws {
    do {
      guard self.title.count <= Task.TITLE_MAX_LEGNTH else {
        throw PersistenceError.constraintError(message: "title should be less than or equal to \(Task.TITLE_MAX_LEGNTH) characters.")
      }
      guard self.title.count >= Task.TITLE_MIN_LENGTH else {
        throw PersistenceError.constraintError(message: "title should be greater than or equal to \(Task.TITLE_MIN_LENGTH) characters.")
      }
      try RealmManager.shared.db.write {
        self.updatedAt = NSDate()
        RealmManager.shared.db.add(self, update: .error)
      }
    } catch let err {
      throw PersistenceError.saveError(error: err)
    }
  }
  
  override static func primaryKey() -> String? {
    return "taskId"
  }
  
  convenience init(title: String) {
    self.init()
    self.title = title
    self.taskId = UUID().uuidString
  }
}
