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
  
  var range: ClosedRange<Int>?
  
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
  
  func configure(_ textInput: String, delegate: TextInputCellUpdating, validTextInputRange range: ClosedRange<Int>? = nil) {
    self.userInputTextView.text = textInput
    self.range = range
    self.delegate = delegate
    self.configureViewStyle(textInput, validTextInputRange: range)
  }
  
  private func configureViewStyle(_ textInput: String, validTextInputRange range: ClosedRange<Int>? = nil) {
    let c = textInput.count
    if let r = range {
      self.userInputTextView.textColor = (r ~= c) ? CustomColor.darkText : CustomColor.scarletCarson
      self.counterLabel.text = "\(c) = [\(r.min()!), \(r.max()!)]"
      self.counterLabel.textColor = (r ~= c) ? CustomColor.darkText : CustomColor.scarletCarson
    } else {
      self.userInputTextView.textColor = CustomColor.darkText
      self.counterLabel.text = "\(c) = [-∞, +∞]"
      self.counterLabel.textColor = CustomColor.darkText
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

extension TextInputCell: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    self.configureViewStyle(textView.text, validTextInputRange: self.range)
    self.delegate?.textDidChange(textView.text)
  }
}
