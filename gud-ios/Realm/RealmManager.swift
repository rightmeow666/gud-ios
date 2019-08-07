//
//  RealmManager.swift
//  gud-ios
//
//  Created by sudofluff on 8/8/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

enum RealmStoreType {
  case `default`
  case test
}

class RealmManager: NSObject {
  let shared = RealmManager()
  
  fileprivate(set) var persistentStoreType: RealmStoreType
  
  fileprivate init(type: RealmStoreType = .default) {
    self.persistentStoreType = type
    super.init()
  }
}
