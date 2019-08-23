//
//  BaseCacheService.swift
//  gud-ios
//
//  Created by sudofluff on 8/3/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class BaseCacheService: NSObject, CacheServicable {
  override init() {
    super.init()
  }
  
  enum DataStoreError: Error {
    case customError(message: String)
  }
}
