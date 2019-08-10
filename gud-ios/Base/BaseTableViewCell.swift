//
//  BaseTableViewCell.swift
//  gud-ios
//
//  Created by sudofluff on 8/9/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
  private func configureView() {
    self.backgroundColor = CustomColor.orange
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.configureView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
