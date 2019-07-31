//
//  TaskListViewController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskListViewController: BaseViewController {
  weak var delegate: TaskListViewControllerDelegate?
  
  lazy var addButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    return button
  }()
  
  lazy var editButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped(_:)))
    return button
  }()
  
  @objc func editButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.controller(didTapEditButton: sender)
  }
  
  @objc func addButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.controller(didTapAddButton: sender)
  }
  
  func configureView() {
    self.navigationItem.rightBarButtonItems = [addButton, editButton]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}
