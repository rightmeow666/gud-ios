//
//  BaseCollectionViewCell.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
  private func configureView() {
    self.backgroundColor = CustomColor.orange
  }
  
  func addLongPressGesture(toView view: UIView, target: Any, action: Selector) {
    let recognizer = UILongPressGestureRecognizer(target: target, action: action)
    recognizer.allowableMovement = 10
    recognizer.numberOfTouchesRequired = 1
    recognizer.minimumPressDuration = 1.3
    view.addGestureRecognizer(recognizer)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
