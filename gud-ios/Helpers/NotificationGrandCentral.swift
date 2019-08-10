//
//  NotificationGrandCentral.swift
//  gud-ios
//
//  Created by sudofluff on 8/12/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

struct NotificationGrandeCentral {
  static func postNotificationToEnableEditMode(isEditing: Bool) {
    let notification = Notification(name: Notification.Name("EditMode"), object: nil, userInfo: ["isEditing" : isEditing])
    NotificationCenter.default.post(notification)
  }
  
  static func observeNotificationToEnableEditMode(_ observer: Any, selector: Selector) {
    NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name("EditMode"), object: nil)
  }
}
