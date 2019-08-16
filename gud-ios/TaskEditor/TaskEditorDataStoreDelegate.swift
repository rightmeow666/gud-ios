//
//  TaskEditorDataStoreDelegate.swift
//  gud-ios
//
//  Created by sudofluff on 8/10/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

protocol TaskEditorDataStoreDelegate: NSObjectProtocol {
  func store(didErr error: Error)
  
  func store(isModified: Bool)
}
