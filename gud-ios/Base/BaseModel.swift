//
//  BaseModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/11/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class BaseModel: Object {
  static let localDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm zzz"
    return formatter
  }()
  
  func getFormattedDateString(unformattedDate: Date, formatter: DateFormatter = BaseModel.localDateFormatter) -> String {
    return formatter.string(from: unformattedDate)
  }
  
  enum PersistenceError: Error {
    case readError(error: Error)
    
    case saveError(error: Error)
    
    case deleteError(error: Error)
    
    case customError(message: String)
  }
}
