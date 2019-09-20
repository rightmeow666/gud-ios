//
//  AlertType.swift
//  gud-ios
//
//  Created by sudofluff on 9/20/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

enum AlertType: String {
  case error = "Error"
  
  case warning = "Warning"
  
  case success = "Success"
  
  var description: String {
    return self.rawValue
  }
}
