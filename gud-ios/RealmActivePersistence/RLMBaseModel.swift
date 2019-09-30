//
//  RLMBaseModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/11/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class RLMBaseModel: Object, Datetime, RecordIdentifiable {
  @objc dynamic var id: String = ""
  
  @objc dynamic var createdAt: Date? = nil
  
  @objc dynamic var updatedAt: Date? = nil
  
  override class func primaryKey() -> String? {
    return "id"
  }
}
