//
//  Folder.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

final class Folder: RLMBaseModel, ActivePersistable {
  @objc dynamic var title: String = ""
  
  var tasks = List<Task>()
  
  static let TITLE_LENGTH = 3...128
  
  static func isTitleValid(title: String) -> Bool {
    let c = title.count
    if Folder.TITLE_LENGTH.contains(c) {
      return true
    } else {
      return false
    }
  }
  
  var beforeSave: BeforeSaveBlock? {
    return {
      if !Folder.isTitleValid(title: self.title) {
        throw DBException.logical("title should be within the range of \(Folder.TITLE_LENGTH.min()!) to \(Folder.TITLE_LENGTH.max()!) characters")
      }
    }
  }
}
