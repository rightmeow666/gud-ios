//
//  TextInputCell.swift
//  gud-ios
//
//  Created by sudofluff on 8/9/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TextInputCell: BaseTableViewCell, UniquelyIdentifable {
  private lazy var userInputTextView: UITextView = {
    let view = UITextView()
    view.font = UIFont.preferredFont(forTextStyle: .body)
    view.layer.cornerRadius = 8
    view.layer.borderWidth = 1
    view.layer.borderColor = CustomColor.offWhite.cgColor
    view.backgroundColor = CustomColor.candyWhite
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var counterLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.textColor = UIColor.lightGray
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private var task: Task?
  
  weak var delegate: TextInputCellUpdating?
  
  private func configureView() {
    self.userInputTextView.delegate = self
    self.selectionStyle = .none
    
    self.backgroundColor = CustomColor.white
    self.contentView.addSubview(self.userInputTextView)
    self.userInputTextView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
    self.userInputTextView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
    self.userInputTextView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
    self.userInputTextView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    
    self.contentView.addSubview(self.counterLabel)
    self.counterLabel.topAnchor.constraint(equalTo: self.userInputTextView.bottomAnchor, constant: 4).isActive = true
    self.counterLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
    self.counterLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
    self.counterLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
  }
  
  func configure(task: Task?, delegate: TextInputCellUpdating) {
    self.task = task
    self.userInputTextView.text = task?.title ?? ""
    let count = task?.title.count ?? 0
    self.userInputTextView.textColor = Task.isTitleValid(title: task?.title ?? "") ? CustomColor.darkText : CustomColor.roseScarlet
    self.counterLabel.text = "\(count) = [\(Task.TITLE_MIN_LENGTH), \(Task.TITLE_MAX_LEGNTH)]"
    self.counterLabel.textColor = Task.isTitleValid(title: task?.title ?? "") ? CustomColor.darkText : CustomColor.roseScarlet
    self.delegate = delegate
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.configureView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TextInputCell: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    let count = textView.text.count
    self.counterLabel.text = "\(count) = [\(Task.TITLE_MIN_LENGTH), \(Task.TITLE_MAX_LEGNTH)]"
    self.counterLabel.textColor = Task.isTitleValid(title: textView.text) ? CustomColor.darkText : CustomColor.roseScarlet
    self.userInputTextView.textColor = Task.isTitleValid(title: textView.text) ? CustomColor.darkText : CustomColor.roseScarlet
    self.delegate?.textDidChange(textView.text)
  }
}
