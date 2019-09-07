//
//  TaskCell.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell, UniquelyIdentifable {
  private let IMAGE_DATA_VIEW_SIZE = CGSize(width: 44, height: 44)
  
  lazy private var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = CustomColor.orange
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
    view.isEditable = false
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy private var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy private var imageDataView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy private var stackView: UIStackView = {
    let view = UIStackView()
    view.axis = .horizontal
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy private var separatorView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private func configureView() {
    self.contentView.backgroundColor = .offWhite
    self.selectionStyle = .none
    self.contentView.addSubview(self.containerView)
    self.containerView.addSubview(self.titleTextView)
    self.containerView.addSubview(self.separatorView)
    self.containerView.addSubview(self.stackView)
    self.containerView.addSubview(self.dateLabel)
    self.containerView.addSubview(self.completionIndicatorView)
    self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    self.containerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    self.containerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
    self.completionIndicatorView.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
    self.completionIndicatorView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
    self.completionIndicatorView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
    self.completionIndicatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
  }
  
  func configure(task: Task?) {
    self.titleTextView.text = task?.title ?? ""
    self.dateLabel.text = task?.createdAtFormattedString
    if let data = task?.imageData {
      self.imageDataView.image = UIImage(data: data)
      self.imageDataView.isHidden = false
    } else {
      self.imageDataView.isHidden = true
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.configureView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
