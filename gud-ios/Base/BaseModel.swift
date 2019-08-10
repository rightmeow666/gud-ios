//
//  BaseModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/11/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class BaseModel: Object {
  enum PersistenceError: Error {
    case readError(error: Error)
    
    case saveError(error: Error)
    
    case deleteError(error: Error)
    
    case constraintError(message: String)
  }
}
