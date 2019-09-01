//
//  TaskEditorViewController.swift
//  gud-ios
//
//  Created by sudofluff on 8/30/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

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
  
  var viewModel: TaskEditorViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension TaskEditorViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.numberOfRows(inSection: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TextInputCell.cellId, for: indexPath) as! TextInputCell
    cell.configure(self.viewModel.getTask().title, delegate: self, validTextInputRange: Task.TITLE_MIN_LENGTH...Task.TITLE_MAX_LEGNTH)
    return cell
  }
}

extension TaskEditorViewController: TextInputCellUpdating {
  func textDidChange(_ text: String) {
    self.viewModel.updateTask(withNewTitle: text)
  }
}
