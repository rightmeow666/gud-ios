//
//  TaskListViewController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskListViewController: BaseViewController {
  lazy var addButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    return button
  }()
  
  @objc func addButtonTapped(_ sender: UIBarButtonItem) {
    print(123)
  }
  
  func configureView() {
    self.view.backgroundColor = .red
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}
