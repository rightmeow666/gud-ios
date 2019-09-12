//
//  TaskCell.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell, UniquelyIdentifable {
  private var imageViewHeightConstraint: NSLayoutConstraint!
  
  lazy private var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = CustomColor.offWhite
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy private var completionIndicatorView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy private var titleTextView: UITextView = {
    let view = UITextView()
    view.isScrollEnabled = false
    view.font = UIFont.preferredFont(forTextStyle: .body)
    view.isEditable = false
    view.backgroundColor = CustomColor.clear
    view.contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy private var dateLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = CustomColor .clear
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy private var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [self.imageDataView, self.dateLabel])
    view.spacing = 4
    view.alignment = .leading
    view.translatesAutoresizingMaskIntoConstraints = false
    view.axis = .vertical
    return view
  }()
  
  lazy private var imageDataView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = CustomColor.clear
    view.contentMode = .scaleAspectFit
    view.clipsToBounds = true
    return view
  }()
  
  lazy private var separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = CustomColor.lightGray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private func configureView() {
    self.contentView.backgroundColor = .clear
    self.selectionStyle = .none
    
    self.contentView.addSubview(self.containerView)
    self.containerView.addSubview(self.titleTextView)
    self.containerView.addSubview(self.separatorView)
    self.containerView.addSubview(self.dateLabel)
    self.containerView.addSubview(self.imageDataView)
    self.containerView.addSubview(self.completionIndicatorView)
    self.containerView.addSubview(self.stackView)
    self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    self.containerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    self.containerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
    
    self.completionIndicatorView.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
    self.completionIndicatorView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
    self.completionIndicatorView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
    self.completionIndicatorView.widthAnchor.constraint(equalToConstant: 5).isActive = true
    
    self.titleTextView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 8).isActive = true
    self.titleTextView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
    self.titleTextView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
    self.titleTextView.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -4).isActive = true
    
    self.stackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
    self.stackView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
    self.stackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -8).isActive = true
    
    self.imageDataView.heightAnchor.constraint(equalToConstant: 256).isActive = true
    self.imageDataView.widthAnchor.constraint(equalToConstant: 256).isActive = true
    
    self.dateLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    
    self.separatorView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
    self.separatorView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
    self.separatorView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
    self.separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
  
  func configure(task: Task) {
    self.titleTextView.text = task.title
    self.dateLabel.text = "Created at: " + task.createdAtFormattedString
    self.completionIndicatorView.backgroundColor = task.isCompleted ? CustomColor.seaweedGreen : CustomColor.mandarinOrange
    self.imageDataView.isHidden = task.imageData == nil ? true : false
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.configureView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
