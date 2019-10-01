//
//  Task.swift
//  gud-ios
//
//  Created by sudofluff on 8/23/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

final class Task: RLMBaseModel, ActivePersistable {
  @objc dynamic var folderId: String = ""
  
  @objc dynamic var title: String = ""
  
  @objc dynamic var expiredAt: Date? = nil
  
  @objc dynamic var imageData: Data? = nil
  
  @objc dynamic var isCompleted: Bool = false
  
  var beforeSave: BeforeSaveBlock? {
    return {
      if self.folderId.count <= 0 {
        throw DBException.logical("folderId cannot be empty")
      } else if !Task.isTitleValid(title: self.title) {
        throw DBException.logical("title should be within the range of \(Task.TITLE_LENGTH.min()!) to \(Task.TITLE_LENGTH.max()!) characters")
      }
    }
  }
  
  static func isTitleValid(title: String) -> Bool {
    let c = title.count
    if Task.TITLE_LENGTH.contains(c) {
      return true
    } else {
      return false
    }
  }
  
  let folder = LinkingObjects(fromType: Folder.self, property: "tasks")
  
  static let TITLE_LENGTH = 3...512
}
