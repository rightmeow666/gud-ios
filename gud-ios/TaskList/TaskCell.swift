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
  
  private var containerViewLeftConstraint: NSLayoutConstraint?
  
  var isEditing: Bool = false {
    didSet {
      self.setEditing(editing: self.isEditing)
    }
  }
  
  override var isSelected: Bool {
    didSet {
      if isEditing {
        self.setSelected(isSelected: isSelected)
      }
    }
  }
  
  override var isHighlighted: Bool {
    didSet {
      self.setHighlighted(isHighlighted: isHighlighted)
    }
  }
  
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
    view.layer.borderColor = CustomColor.offWhite.cgColor
    view.backgroundColor = CustomColor.clear
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isHidden = true
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
    self.containerViewLeftConstraint = self.containerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16)
    self.containerViewLeftConstraint?.isActive = true
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
  
  private func setEditing(editing: Bool) {
    self.containerViewLeftConstraint?.constant = editing ? 54 : 16
    UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction], animations: {
      self.layoutIfNeeded()
    }) { (completed) in
      self.indicatorView.isHidden = editing ? false : true
    }
  }
  
  private func setSelected(isSelected: Bool) {
    if self.isEditing {
      UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction], animations: {
        self.containerView.transform = isSelected ? CGAffineTransform.init(scaleX: 1.03, y: 1.03) : CGAffineTransform.identity
        self.containerView.layer.borderColor = isSelected ? CustomColor.roseScarlet.cgColor : CustomColor.clear.cgColor
        self.containerView.layer.borderWidth = isSelected ? 1 : 0
        self.indicatorView.backgroundColor = isSelected ? CustomColor.roseScarlet : CustomColor.clear
      }, completion: nil)
    }
  }
  
  private func setHighlighted(isHighlighted: Bool) {
    self.containerView.backgroundColor = isHighlighted ? CustomColor.candyWhite : CustomColor.offWhite
  }
  
  private func addLongPressGesture(toView view: UIView) {
    let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.postNotificationToEnableEditMode(_:)))
    recognizer.allowableMovement = 10
    recognizer.numberOfTouchesRequired = 1
    recognizer.minimumPressDuration = 1.3
    view.addGestureRecognizer(recognizer)
  }
  
  @objc func postNotificationToEnableEditMode(_ recognizer: UILongPressGestureRecognizer) {
    if self.isEditing == false {
      let notification = Notification(name: Notification.Name.EditMode, object: nil, userInfo: ["isEditing" : true])
      NotificationCenter.default.post(notification)
    }
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
    self.addLongPressGesture(toView: self.containerView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
