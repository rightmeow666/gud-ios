//
//  RealmManager.swift
//  gud-ios
//
//  Created by sudofluff on 8/8/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

class RealmManager: NSObject {
  enum Config {
    case development
    case test
    case production
  }
  
  static private let developmentConfig = Realm.Configuration(fileURL: URL.inDocumentDirectory(filename: "default.realm"), schemaVersion: 0, migrationBlock: nil, objectTypes: [Folder.self, Task.self])

  static private let testConfig = Realm.Configuration(fileURL: URL.inDocumentDirectory(filename: "test.realm"), schemaVersion: 0, migrationBlock: nil, objectTypes: [Folder.self, Task.self])

  static private let productionConfig = Realm.Configuration(fileURL: URL.inDocumentDirectory(filename: "production.realm"), schemaVersion: 0, migrationBlock: nil, objectTypes: [Folder.self, Task.self])
  
  static let shared = RealmManager()
  
  let config: Realm.Configuration
  
  lazy var db: Realm = {
    return try! Realm(configuration: self.config)
  }()
  
  lazy var pathForDefaultContainer: URL? = {
    return self.db.configuration.fileURL
  }()
  
  init(config: Realm.Configuration = RealmManager.developmentConfig) {
    self.config = config
    super.init()
    print(self.pathForDefaultContainer!)
  }
}
