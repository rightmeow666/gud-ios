//
//  BaseModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/11/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class BaseModel: Object, DateFormatable {
  @objc dynamic var id: String = ""
  
  @objc dynamic var createdAt: Date? = nil
  
  @objc dynamic var updatedAt: Date? = nil
  
  var createdAtFormattedString: String {
    guard let d = self.createdAt else { return "" }
    return self.formattedDateString(d)
  }
  
  var updatedAtFormattedString: String {
    guard let d = self.updatedAt else { return "" }
    return self.formattedDateString(d)
  }
  
  enum PersistenceError: Error {
    case saveError(error: Error)
    
    case deletetionError(error: Error)
    
    case customError(message: String)
  }
}
