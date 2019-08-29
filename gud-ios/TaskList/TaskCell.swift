//
//  TaskCell.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskCell: BaseTableViewCell, UniquelyIdentifable {
  private let IMAGEDATAVIEWSIZE = CGSize(width: 44, height: 44)
  
  lazy var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var completionIndicatorView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var titleTextView: UITextView = {
    let view = UITextView()
    view.isScrollEnabled = false
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var imageDataView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [self.titleTextView, self.imageDataView])
    view.axis = .horizontal
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var separatorView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private func configureView() {
    self.backgroundColor = CustomColor.clear
    self.contentView.addSubview(self.containerView)
    self.contentView.addSubview(self.completionIndicatorView)
    self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    self.containerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    self.containerView.leftAnchor.constraint(equalTo: self.completionIndicatorView.rightAnchor).isActive = true
    self.completionIndicatorView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    self.completionIndicatorView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
    self.completionIndicatorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    self.completionIndicatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
    self.containerView.addSubview(self.separatorView)
    self.separatorView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
    self.separatorView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
    self.separatorView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
    self.separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    self.contentView.addSubview(self.stackView)
    self.stackView.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
    self.stackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
    self.stackView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
    self.stackView.bottomAnchor.constraint(equalTo: self.separatorView.topAnchor).isActive = true
    self.imageDataView.widthAnchor.constraint(equalToConstant: self.IMAGEDATAVIEWSIZE.width).isActive = true
    self.imageDataView.heightAnchor.constraint(equalToConstant: self.IMAGEDATAVIEWSIZE.height).isActive = true
  }
  
  func configure(task: Task?) {
    self.titleTextView.text = task?.title ?? ""
    self.dateLabel.text = task?.createdAt.toString ?? ""
    if let data = task?.imageData {
      self.imageDataView.image = UIImage(data: data)
      self.imageDataView.isHidden = false
    } else {
      self.imageDataView.isHidden = true
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.configureView()
  }
}
