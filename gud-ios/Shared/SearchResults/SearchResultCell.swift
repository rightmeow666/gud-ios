//
//  SearchResultCell.swift
//  gud-ios
//
//  Created by sudofluff on 9/25/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class SearchResultCell: BaseTableViewCell, UniquelyIdentifable {
  private func configureView() {
    // TODO: implement this
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.configureView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
