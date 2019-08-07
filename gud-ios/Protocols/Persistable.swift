//
//  Persistable.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol Persistable {
  associatedtype ExplicitSelf = Self
  
  typealias BeforeSave = () -> Void
  
  typealias AfterSave = () -> Void
  
  var isValid: Bool { get }
  
  func save(block: @escaping (Error?) -> Void) throws
  
  func delete(block: @escaping (Error?) -> Void)
  
  static func find(byIdentifier identifier: String) -> ExplicitSelf?
  
  static func all(tableName: String) -> [ExplicitSelf]
  
  static func purge(tableName: String, block: @escaping (Error?) -> Void)
}

extension Persistable {
  var isValid: Bool { return true }
}
