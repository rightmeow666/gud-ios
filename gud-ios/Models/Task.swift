//
//  Task.swift
//  gud-ios
//
//  Created by sudofluff on 8/23/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

final class Task: RLMBaseModel, RLMPersistable {
  @objc dynamic var folderId: String = ""
  
  @objc dynamic var title: String = ""
  
  @objc dynamic var expiredAt: Date? = nil
  
  @objc dynamic var imageData: Data? = nil
  
  @objc dynamic var isCompleted: Bool = false
  
  var beforeSave: BeforeSaveBlock? {
    return {
      if self.folderId.count <= 0 {
        throw DBException.logical("folderId cannot be empty")
      } else if self.title.count > Task.TITLE_MAX_LEGNTH {
        throw DBException.logical("title should be less than or equal to \(Task.TITLE_MAX_LEGNTH) characters.")
      } else if self.title.count < Task.TITLE_MIN_LENGTH {
        throw DBException.logical("title should be greater than or equal to \(Task.TITLE_MIN_LENGTH) characters.")
      }
    }
  }
  
  static func isTitleValid(title: String) -> Bool {
    let c = title.count
    if c >= Task.TITLE_MIN_LENGTH && c <= Task.TITLE_MAX_LEGNTH {
      return true
    } else {
      return false
    }
  }
  
  let folder = LinkingObjects(fromType: Folder.self, property: "tasks")
  
  static let TITLE_MAX_LEGNTH: Int = 512
  
  static let TITLE_MIN_LENGTH: Int = 3
}
