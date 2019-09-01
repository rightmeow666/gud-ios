//
//  Task.swift
//  gud-ios
//
//  Created by sudofluff on 8/23/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

final class Task: BaseModel, RLMPersistable {
  @objc dynamic var folderId: String = ""
  
  @objc dynamic var title: String = ""
  
  @objc dynamic var expiredAt: Date? = nil
  
  @objc dynamic var imageData: Data? = nil
  
  @objc dynamic var isCompleted: Bool = false
  
  var beforeSave: BeforeSaveBlock? {
    let block: BeforeSaveBlock = {
      if self.folderId.count <= 0 {
        throw PersistenceError.customError(message: "folderId cannot be empty")
      } else if self.title.count > Task.TITLE_MAX_LEGNTH {
        throw PersistenceError.customError(message: "title should be less than or equal to \(Task.TITLE_MAX_LEGNTH) characters.")
      } else if self.title.count < Task.TITLE_MIN_LENGTH {
        throw PersistenceError.customError(message: "title should be greater than or equal to \(Task.TITLE_MIN_LENGTH) characters.")
      }
    }
    return block
  }
  
  let folder = LinkingObjects(fromType: Folder.self, property: "tasks")
  
  static let TITLE_MAX_LEGNTH: Int = 512
  
  static let TITLE_MIN_LENGTH: Int = 3
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
