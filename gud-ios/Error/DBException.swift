//
//  DBException.swift
//  gud-ios
//
//  Created by sudofluff on 9/20/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

enum DBException: Error {
  case `internal`(_ error: Error)
  
  case logical(_ msg: String)
}

extension DBException: LocalizedError {
  var localizedDescription: String {
    switch self {
    case .internal(let err):
      return err.localizedDescription
    case .logical(let msg):
      return msg
    }
  }
}

extension DBException: CustomNSError {
  var errorDescription: String? {
    switch self {
    case .internal(let err):
      return err.localizedDescription
    case .logical(let msg):
      return msg
    }
  }
}
