//
//  FolderFactory.swift
//  gud-iosTests
//
//  Created by sudofluff on 10/2/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Nimble
import Quick
import Fakery
@testable import gud_ios

struct FolderFactory {
  let faker = Faker(locale: "nb-NO")
  
  func make(_ count: Int) -> [Folder] {
    guard count > 0 else { return [] }
    var results: [Folder] = []
    for _ in 0 ..< count {
      let f = Folder.create { () -> Folder in
        let f = Folder()
        f.title = faker.commerce.department()
        return f
      }
      results.append(f)
    }
    return results
  }
}
