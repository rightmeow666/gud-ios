//
//  TaskListViewController.swift
//  gud-ios
//
//  Created by sudofluff on 8/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol TaskListViewControllerDelegate: NSObjectProtocol {
  func taskListViewController(_ controller: TaskListViewController, didTapAddButton button: UIBarButtonItem)
}

class TaskListViewController: BaseViewController {
  weak var delegate: TaskListViewControllerDelegate?
  
  var viewModel: TaskListViewModel!
  
  lazy private var tableView: UITableView = {
    let view = UITableView(frame: self.view.frame, style: .plain)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.estimatedRowHeight = 56
    view.rowHeight = UITableView.automaticDimension
    view.scrollsToTop = true
    view.allowsMultipleSelection = false
    view.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellId)
    view.delegate = self
    view.dataSource = self
    return view
  }()
  
  lazy private var addButton: UIBarButtonItem = {
    let button = UIBarButtonItem(image: UIImage(named: "Add"), style: .plain, target: self, action: #selector(addButtonTapped(_:)))
    return button
  }()
  
  @objc private func addButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.taskListViewController(self, didTapAddButton: sender)
  }
  
  private func configureView() {
    self.navigationItem.title = self.viewModel.viewControllerTitle
    self.view.backgroundColor = .white
    self.navigationItem.setRightBarButtonItems([self.addButton], animated: true)
    self.view.addSubview(self.tableView)
    self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
    self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
    self.viewModel.getTaskList()
  }
}

extension TaskListViewController: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//    // TODO: present toggle button for complete / pending action && edit action
//    return nil
//  }
//  
//  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//    // TODO: present delete button
//    return nil
//  }
}

extension TaskListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.getNumberOfItems(inSection: section)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.viewModel.getNumberOfSections()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellId, for: indexPath) as! TaskCell
    if let t = self.viewModel.getTask(atIndex: indexPath.row) {
      cell.configure(task: t)
    }
    return cell
  }
}

extension TaskListViewController: TaskListViewModelDelegate {
  func didGetTaskList(_ vm: TaskListViewModel) {
    self.tableView.reloadData()
  }
  
  func viewModel(_ vm: TaskListViewModel, deletedIndice: [Int], insertedIndice: [Int], modifiedIndice: [Int]) {
    let ops = BlockOperation {
      let dis = deletedIndice.map({ IndexPath(item: $0, section: 0) })
      let iis = insertedIndice.map({ IndexPath(item: $0, section: 0) })
      let uis = modifiedIndice.map({ IndexPath(item: $0, section: 0) })
      self.tableView.deleteRows(at: dis, with: .automatic)
      self.tableView.insertRows(at: iis, with: .automatic)
      self.tableView.reloadRows(at: uis, with: .automatic)
    }
    self.tableView.performBatchUpdates({
      ops.start()
    }) { (completed) in
      self.tableView.scrollsToTop()
    }
  }
  
  func viewModel(_ vm: TaskListViewModel, didErr error: Error) {
    self.presentAlert("Error", message: error.localizedDescription, completion: nil)
  }
}
