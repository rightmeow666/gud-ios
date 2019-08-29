//
//  FolderListDropdownMenuDataStore.swift
//  gud-ios
//
//  Created by sudofluff on 8/28/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class FolderListDropdownMenuDataStore: BaseCacheService {
  enum DataSource: Int, CaseIterable {
    case New
    case Edit
    
    var description: String {
      switch self {
      case .Edit:
        return "Edit"
      case .New:
        return "New"
      }
    }
  }
  
  var numberOfOptions: Int {
    return DataSource.allCases.count
  }
  
  func getTitleForOption(atIndex index: Int) -> String? {
    return self.getOption(atIndex: index)?.description
  }
  
  func getOption(atIndex index: Int) -> DataSource? {
    return DataSource(rawValue: index)
  }
}
