//
//  TaskListViewControllerDelegate.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol TaskListViewControllerDelegate: NSObjectProtocol {
  func controller(didTapAddButton button: UIBarButtonItem)
  
  func controller(didTapEditButton button: UIBarButtonItem)
  
  func controller(didSelectItemAt indexPath: IndexPath)
  
  func controller(didDeselectItemAt indexPath: IndexPath)
}
