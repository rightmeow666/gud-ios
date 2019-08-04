//
//  Helpers.swift
//  gud-ios
//
//  Created by sudofluff on 8/1/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
  let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
  label.numberOfLines = 0
  label.lineBreakMode = NSLineBreakMode.byWordWrapping
  label.font = font
  label.text = text
  label.sizeToFit()
  return label.frame.height
}

extension Notification.Name {
  static let EditMode = Notification.Name("EditMode")
}
