//
//  FolderListDependencyOptions.swift
//  gud-ios
//
//  Created by sudofluff on 8/3/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

struct FolderListDependencyOptions {
  let networkService: GudNetworkService
  
  let folderListCacheService: FolderListDataStore
  
  let dropdownMenuCacheService: FolderListDropdownMenuDataStore
}
