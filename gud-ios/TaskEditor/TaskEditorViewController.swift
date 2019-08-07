//
//  TaskEditorViewController.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskEditorViewController: BaseViewController {
  weak var delegate: TaskEditorViewControllerDelegate?
  
  lazy var commitButton: UIBarButtonItem = {
    let button = UIBarButtonItem(title: "Commit", style: .done, target: self, action: #selector(self.commitButtonTapped(_:)))
    return button
  }()
  
  lazy var cancelButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelButtonTapped(_:)))
    return button
  }()
  
  private func configureView() {
    self.navigationItem.title = "Task Editor"
    self.navigationItem.setRightBarButtonItems([self.cancelButton], animated: true)
    self.navigationItem.setLeftBarButtonItems([self.commitButton], animated: true)
  }
  
  @objc func commitButtonTapped(_ sender: UIBarButtonItem) {
    print("Commit button tapped")
  }
  
  @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.controller(didTapCancelButton: sender)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}

extension TaskEditorViewController: TaskEditorDataStoreDelegate {
  func store(isModified: Bool) {
    self.commitButton.isEnabled = isModified
  }
}
