//
//  Folder.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

final class Folder: BaseModel, RLMPersistable {
  @objc dynamic var title: String = ""
  
  var tasks = List<Task>()
  
  static let TITLE_MAX_LEGNTH: Int = 128
  
  static let TITLE_MIN_LENGTH: Int = 3
  
  static func isTitleValid(title: String) -> Bool {
    let c = title.count
    if c >= Folder.TITLE_MIN_LENGTH && c <= Folder.TITLE_MAX_LEGNTH {
      return true
    } else {
      return false
    }
  }
  
  var beforeSave: BeforeSaveBlock? {
    let block: BeforeSaveBlock = {
      guard self.title.count <= Folder.TITLE_MAX_LEGNTH else {
        throw PersistenceError.customError(message: "title should be less than or equal to \(Folder.TITLE_MAX_LEGNTH) characters.")
      }
      guard self.title.count >= Folder.TITLE_MIN_LENGTH else {
        throw PersistenceError.customError(message: "title should be greater than or equal to \(Folder.TITLE_MIN_LENGTH) characters.")
      }
    }
    return block
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
