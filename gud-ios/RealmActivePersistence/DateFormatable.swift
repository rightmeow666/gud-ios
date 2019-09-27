//
//  DateFormatable.swift
//  gud-ios
//
//  Created by sudofluff on 8/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol DateFormatable: NSObjectProtocol {
  static var formatter: DateFormatter { get }
  
  func formattedDateString(_ unformattedDate: Date) -> String
}

extension DateFormatable {
  static var formatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm zzz"
    return formatter
  }
  
  func formattedDateString(_ unformattedDate: Date) -> String {
    return Self.formatter.string(from: unformattedDate)
  }
}
