//
//  TaskEditorViewController.swift
//  gud-ios
//
//  Created by sudofluff on 8/30/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol TaskEditorViewControllerDelegate: NSObjectProtocol {
  func taskEditorViewController(_ controller: TaskEditorViewController, didTapCancelButton button: UIBarButtonItem, hasUncommittedChanges: Bool)
}

class TaskEditorViewController: BaseViewController {
  lazy private var tableView: UITableView = {
    let view = UITableView(frame: self.view.frame, style: .grouped)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alwaysBounceVertical = true
    view.scrollsToTop = true
    view.register(TextInputCell.self, forCellReuseIdentifier: TextInputCell.cellId)
    view.backgroundColor = CustomColor.white
    view.estimatedRowHeight = 44
    view.rowHeight = UITableView.automaticDimension
    view.separatorStyle = .none
    view.dataSource = self
    return view
  }()
  
  lazy private var commitButton: UIBarButtonItem = {
    let button = UIBarButtonItem(title: "Commit", style: .done, target: self, action: #selector(self.commitButtonTapped(_:)))
    return button
  }()
  
  lazy private var cancelButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelButtonTapped(_:)))
    return button
  }()
  
  @objc private func commitButtonTapped(_ sender: UIBarButtonItem) {
    self.viewModel.commitChanges()
  }
  
  @objc private func cancelButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.taskEditorViewController(self, didTapCancelButton: sender, hasUncommittedChanges: self.viewModel.isModified)
  }
  
  private func configureView() {
    self.view.backgroundColor = CustomColor.white
    self.navigationItem.setRightBarButtonItems([self.commitButton], animated: true)
    self.navigationItem.setLeftBarButtonItems([self.cancelButton], animated: true)
    self.view.addSubview(self.tableView)
    self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
  }
  
  weak var delegate: TaskEditorViewControllerDelegate?
  
  var viewModel: TaskEditorViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}

extension TaskEditorViewController: TaskEditorViewModelDelegate {
  func viewModel(_ vm: TaskEditorViewModel, didErr error: Error) {
    // TODO: implement error handling
    self.presentAlert(error.localizedDescription, alertType: .error, completion: nil)
  }
  
  func didCommitChanges(_ vm: TaskEditorViewModel, withMessage message: String) {
    // TODO: handle success on the UI layer, properly
    self.dismiss(animated: true, completion: nil)
  }
}

extension TaskEditorViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.viewModel.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.numberOfRows(inSection: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TextInputCell.cellId, for: indexPath) as! TextInputCell
    cell.configure(self.viewModel.getTask().title, delegate: self, validTextInputRange: Task.TITLE_LENGTH)
    return cell
  }
}

extension TaskEditorViewController: TextInputCellUpdating {
  func textDidChange(_ text: String) {
    self.viewModel.updateTask(withNewTitle: text)
  }
}
