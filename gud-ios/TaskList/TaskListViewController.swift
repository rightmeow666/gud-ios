//
//  TaskListViewController.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskListViewController: BaseViewController {
  lazy private var tableView: UITableView = {
    let view = UITableView(frame: self.view.frame, style: .grouped)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self
    view.dataSource = self
    view.estimatedRowHeight = 56
    view.rowHeight = UITableView.automaticDimension
    return view
  }()
  
  lazy private var moreButton: UIBarButtonItem = {
    let button = UIBarButtonItem(image: UIImage(named: "More"), style: .plain, target: self, action: #selector(moreButtonTapped(_:)))
    return button
  }()
  
  @objc private func moreButtonTapped(_ sender: UIBarButtonItem) {
    // segue to dropdown menu
  }
  
  private func configureView() {
    self.view.backgroundColor = .white
    self.navigationItem.setRightBarButtonItems([self.moreButton], animated: true)
    self.view.addSubview(self.tableView)
    self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
    self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}

extension TaskListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    // TODO: present toggle button for complete / pending action
    return nil
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    // TODO: present delete button
    return nil
  }
}

extension TaskListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return BaseTableViewCell()
  }
}
