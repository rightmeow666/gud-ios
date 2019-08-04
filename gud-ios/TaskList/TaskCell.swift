//
//  TaskCell.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskCell: BaseCollectionViewCell, UniquelyIdentifable {
  /// Height of cell minus titleLabel height
  static let minimumHeight: CGFloat = 8 + 16 + 8 + 16 + 16 + 16 + 8
  
  lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = CustomColor.offWhite
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 8
    return view
  }()
  
  lazy var indicatorView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 11
    view.clipsToBounds = true
    view.layer.borderWidth = 1
    view.layer.borderColor = CustomColor.white.cgColor
    view.backgroundColor = CustomColor.mandarinOrange
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Mauris sit amet aliquam mauris, sed dapibus nunc. Proin"
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var statsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [self.dateLabel, self.statsLabel])
    view.spacing = 8
    view.alignment = UIStackView.Alignment.lastBaseline
    view.distribution = UIStackView.Distribution.fill
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private func configureView() {
    self.contentView.addSubview(self.containerView)
    self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
    self.containerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
    self.containerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
    self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
    
    self.contentView.addSubview(self.indicatorView)
    self.indicatorView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
    self.indicatorView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: 0).isActive = true
    self.indicatorView.widthAnchor.constraint(equalToConstant: 22).isActive = true
    self.indicatorView.heightAnchor.constraint(equalToConstant: 22).isActive = true
    
    self.containerView.addSubview(self.titleLabel)
    self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16).isActive = true
    self.titleLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
    self.titleLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
    
    self.containerView.addSubview(self.subtitleLabel)
    self.subtitleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
    self.subtitleLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
    self.subtitleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.containerView.rightAnchor, constant: -16).isActive = true
    
    self.containerView.addSubview(self.stackView)
    self.stackView.heightAnchor.constraint(equalToConstant: 16).isActive = true
    self.stackView.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 0).isActive = true
    self.stackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
    self.stackView.rightAnchor.constraint(lessThanOrEqualTo: self.containerView.rightAnchor, constant: -16).isActive = true
    self.stackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16).isActive = true
  }
  
  func configure(task: Task?) {
    self.titleLabel.text = task?.title ?? "Untitled"
    self.subtitleLabel.text = "subtitle should show the title of task's first child from its array"
    self.dateLabel.text = "12/21/2019"
    self.statsLabel.text = "200"
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
