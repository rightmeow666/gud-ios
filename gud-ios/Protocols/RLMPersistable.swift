//
//  RLMPersistable.swift
//  gud-ios
//
//  Created by sudofluff on 8/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

typealias BeforeSaveBlock = () throws -> Void

typealias OnSaveBlock = () -> Void

typealias AfterSaveBlock = () -> Void

protocol RLMPersistable where Self: BaseModel {
  var beforeSave: BeforeSaveBlock? { get }
  
  var afterSave: AfterSaveBlock? { get }
  
  static func find(_ id: String) -> Self?
  
  static func findAll(byPredicate predicate: NSPredicate?, sortedBy keyPath: String, ascending: Bool) -> Results<Self>
  
  static func create(_ block: () -> Self) -> Self
  
  static func deleteAll(_ objects: [Self]) throws
  
  func save(_ block: OnSaveBlock) throws
  
  func delete() throws
}

extension RLMPersistable {
  var beforeSave: BeforeSaveBlock? { return nil }
  
  var afterSave: AfterSaveBlock? { return nil }
  
  static func find(_ id: String) -> Self? {
    return RealmManager.shared.db.object(ofType: self, forPrimaryKey: id)
  }
  
  static func findAll(byPredicate predicate: NSPredicate?, sortedBy keyPath: String, ascending: Bool) -> Results<Self> {
    if let p = predicate {
      return RealmManager.shared.db.objects(self).filter(p).sorted(byKeyPath: keyPath, ascending: ascending)
    } else {
      return RealmManager.shared.db.objects(self).sorted(byKeyPath: keyPath, ascending: ascending)
    }
  }
  
  static func create(_ block: () -> Self) -> Self {
    let t = block()
    t.id = UUID().uuidString
    t.updatedAt = Date()
    t.createdAt = Date()
    return t
  }
  
  static func deleteAll(_ objects: [Self]) throws {
    do {
      try RealmManager.shared.db.write {
        RealmManager.shared.db.delete(objects)
      }
    } catch let err {
      throw PersistenceError.deletetionError(error: err)
    }
  }
  
  func save(_ block: OnSaveBlock) throws {
    do {
      try self.beforeSave?()
      try RealmManager.shared.db.write {
        block()
        self.updatedAt = Date()
        RealmManager.shared.db.add(self)
      }
      self.afterSave?()
    } catch let err {
      throw PersistenceError.saveError(error: err)
    }
  }
  
  func delete() throws {
    do {
      try RealmManager.shared.db.write {
        RealmManager.shared.db.delete(self)
      }
    } catch let err {
      throw PersistenceError.deletetionError(error: err)
    }
  }
}
