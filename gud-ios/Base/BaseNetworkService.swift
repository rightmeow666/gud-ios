//
//  BaseNetworkService.swift
//  gud-ios
//
//  Created by sudofluff on 8/3/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class BaseNetworkService: NSObject, NetworkServicable {
  func invoke() throws {
    fatalError("Override this method")
  }
}
