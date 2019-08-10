//
//  TextInputCellUpdating.swift
//  gud-ios
//
//  Created by sudofluff on 8/11/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol TextInputCellUpdating: NSObjectProtocol {
  func textDidChange(_ text: String)
}
