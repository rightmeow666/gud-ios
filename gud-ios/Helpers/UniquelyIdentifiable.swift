//
//  UniquelyIdentifiable.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol UniquelyIdentifable: class {
  associatedtype ExplicitSelf = Self
  
  static var id: String { get }
  
  static var cellId: String { get }
  
  static var storyboardId: String { get }
  
  static var name: String { get }
  
  static var nibName: String { get }
}

extension UniquelyIdentifable {
  static var id: String {
    return String(describing: ExplicitSelf.self)
  }
  
  static var cellId: String {
    return String(describing: ExplicitSelf.self)
  }
  
  static var viewId: String {
    return String(describing: ExplicitSelf.self)
  }
  
  static var storyboardId: String {
    return String(describing: ExplicitSelf.self)
  }
  
  static var name: String {
    return String(describing: ExplicitSelf.self)
  }
  
  static var nibName: String {
    return String(describing: ExplicitSelf.self)
  }
}
