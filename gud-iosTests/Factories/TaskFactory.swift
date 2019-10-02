//
//  TaskFactory.swift
//  gud-iosTests
//
//  Created by sudofluff on 10/2/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Nimble
import Quick
import Fakery
@testable import gud_ios

struct TaskFactory {
  let faker = Faker(locale: "nb-NO")
  
  func make(_ count: Int, parentFolder: Folder) -> [Task] {
    guard count > 0 else { return [] }
    var results: [Task] = []
    for _ in 0 ..< count {
      let t = Task.create { () -> Task in
        let t = Task()
        t.title = faker.commerce.productName()
        t.folderId = parentFolder.id
        t.isCompleted = faker.number.randomBool()
        return t
      }
      results.append(t)
    }
    return results
  }
}
