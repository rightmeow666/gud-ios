//
//  Folder.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

final class Folder: RLMBaseModel, RLMPersistable {
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
    return {
      if self.title.count > Folder.TITLE_MAX_LEGNTH {
        throw DBException.logical("title should be less than or equal to \(Folder.TITLE_MAX_LEGNTH) characters.")
      } else if self.title.count < Folder.TITLE_MIN_LENGTH {
        throw DBException.logical("title should be greater than or equal to \(Folder.TITLE_MIN_LENGTH) characters.")
      }
    }
  }
}
