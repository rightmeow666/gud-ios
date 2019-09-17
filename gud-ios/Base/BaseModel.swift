//
//  BaseModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/11/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

enum DBException: Error {
  case internalError(error: Error)
  
  case logicalError(message: String)
  
  var message: String {
    switch self {
    case .internalError(error: let err):
      return err.localizedDescription
    case .logicalError(message: let msg):
      return msg
    }
  }
}

class BaseModel: Object, DateFormatable {
  @objc dynamic var id: String = ""
  
  @objc dynamic var createdAt: Date? = nil
  
  @objc dynamic var updatedAt: Date? = nil
  
  var createdAtFormattedString: String {
    guard let d = self.createdAt else { return "Malformatted date" }
    return self.formattedDateString(d)
  }
  
  var updatedAtFormattedString: String {
    guard let d = self.updatedAt else { return "Malformatted date" }
    return self.formattedDateString(d)
  }
}
