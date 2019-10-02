//
//  FolderFactory.swift
//  gud-iosTests
//
//  Created by sudofluff on 10/2/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Nimble
import Quick
@testable import gud_ios

struct FolderFactory {
  func make(_ count: Int) -> [Folder] {
    guard count > 0 else { return [] }
    var results: [Folder] = []
    for _ in 0 ..< count {
      
    }
    return results
  }
}
