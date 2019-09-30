//
//  Datetime.swift
//  gud-ios
//
//  Created by sudofluff on 9/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

protocol Datetime {
  var createdAt: Date? { get }
  
  var updatedAt: Date? { get }
  
  static var formatter: DateFormatter { get }
  
  func formattedDateString(_ unformattedDate: Date) -> String
}

extension Datetime {
  static var formatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm zzz"
    return formatter
  }
  
  func formattedDateString(_ unformattedDate: Date) -> String {
    return Self.formatter.string(from: unformattedDate)
  }
}

extension Datetime where Self: RLMBaseModel {
  var createdAtFormattedString: String {
    guard let d = self.createdAt else { return "Malformatted date" }
    return self.formattedDateString(d)
  }
  
  var updatedAtFormattedString: String {
    guard let d = self.updatedAt else { return "Malformatted date" }
    return self.formattedDateString(d)
  }
}
