//
//  RealmManager.swift
//  gud-ios
//
//  Created by sudofluff on 8/8/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class RealmManager: NSObject {
  static let shared = RealmManager()
  
  lazy var db: Realm = {
    return try! Realm(configuration: self.config)
  }()
  
  private let config: Realm.Configuration
  
  lazy private var pathForDefaultContainer: URL? = {
    return self.db.configuration.fileURL
  }()
  
  private init(_ env: Environment = .development) {
    var config = Realm.Configuration()
    config.schemaVersion = 0
    config.migrationBlock = nil
    config.objectTypes = [Folder.self, Task.self]
    switch env {
    case .development:
      config.fileURL = URL.inDocumentDirectory(filename: "default.realm")
    case .test:
      config.fileURL = URL.inDocumentDirectory(filename: "test.realm")
    case .production:
      config.fileURL = URL.inDocumentDirectory(filename: "prod.realm")
    }
    self.config = config
    super.init()
    print(self.pathForDefaultContainer!)
  }
  
  func purge() throws {
    try self.db.write {
      self.db.deleteAll()
    }
  }
}
