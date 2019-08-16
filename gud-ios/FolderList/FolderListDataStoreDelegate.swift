//
//  FolderListDataStoreDelegate.swift
//  gud-ios
//
//  Created by sudofluff on 8/10/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift

protocol FolderListDataStoreDelegate: NSObjectProtocol {
  func store(didErr error: Error)
  
  func store(didGetFolderList list: Results<Folder>)
  
  func store(didUpdateFolderList list: Results<Folder>, deletedIndice: [Int], insertedIndice: [Int], updatedIndice: [Int])
}
