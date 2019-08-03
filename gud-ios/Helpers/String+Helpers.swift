//
//  String+Helpers.swift
//  gud-ios
//
//  Created by sudofluff on 8/1/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

extension String {
  func heightForText(systemFontSize size: CGFloat, width: CGFloat) -> CGFloat {
    let font = UIFont.systemFont(ofSize: size)
    let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil)
    return ceil(rect.height)
  }
}
