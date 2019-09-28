//
//  SearchResultCell.swift
//  gud-ios
//
//  Created by sudofluff on 9/25/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class SearchResultCell: BaseTableViewCell, UniquelyIdentifable {
  private var searchResult: SearchResult?
  
  lazy private var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = CustomColor.offWhite
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy private var titleLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = CustomColor .clear
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy private var subtitleLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = CustomColor .clear
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy private var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [self.titleLabel, self.subtitleLabel])
    view.spacing = 4
    view.alignment = .leading
    view.translatesAutoresizingMaskIntoConstraints = false
    view.axis = .vertical
    return view
  }()
  
  private func configureView() {
    self.contentView.backgroundColor = .clear
    self.selectionStyle = .none
    
    self.contentView.addSubview(self.containerView)
    self.containerView.addSubview(self.stackView)
    
    self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    self.containerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    self.containerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
    
    self.stackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
    self.stackView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
    self.stackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -8).isActive = true
    
    self.titleLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    self.subtitleLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
  }
  
  func configure(searchResult: SearchResult) {
    self.searchResult = searchResult
    self.titleLabel.text = searchResult.title
    self.subtitleLabel.text = searchResult.subtitle
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.configureView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
