//
//  Coordinatable.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol Coordinatable {
  func start()
  
  func start(with option: DeepLinkOption?)
}

extension Coordinatable {
  func start(with option: DeepLinkOption?) {}
}
