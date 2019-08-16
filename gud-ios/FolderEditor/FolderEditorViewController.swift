//
//  FolderEditorViewController.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class FolderEditorViewController: BaseViewController {
  weak var delegate: FolderEditorViewControllerDelegate?
  
  var networkService: GudNetworkService?
  
  var dataStore: FolderEditorDataStore?
  
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
  
  lazy private var pullButton: UIBarButtonItem = {
    let button = UIBarButtonItem(title: "Pull", style: .done, target: self, action: #selector(self.pullButtonTapped(_:)))
    return button
  }()
  
  lazy private var pushButton: UIBarButtonItem = {
    let button = UIBarButtonItem(title: "Push", style: .done, target: self, action: #selector(self.pushButtonTapped(_:)))
    return button
  }()
  
  lazy private var commitButton: UIBarButtonItem = {
    let button = UIBarButtonItem(title: "Commit", style: .done, target: self, action: #selector(self.commitButtonTapped(_:)))
    return button
  }()
  
  lazy private var cancelButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelButtonTapped(_:)))
    return button
  }()
  
  private func configureView() {
    self.navigationItem.setRightBarButtonItems([self.cancelButton], animated: true)
    self.navigationItem.setLeftBarButtonItems([self.pullButton, self.commitButton, self.pushButton], animated: true)
    self.view.backgroundColor = CustomColor.white
    self.view.addSubview(self.tableView)
    self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
  }
  
  @objc private func pullButtonTapped(_ sender: UIBarButtonItem) {
    // TODO: Pull new changes from remote
    print("Pull button tapped")
  }
  
  @objc private func pushButtonTapped(_ sender: UIBarButtonItem) {
    // TODO: Push new changes to remote
    print("Push new changes to remote")
  }
  
  @objc private func commitButtonTapped(_ sender: UIBarButtonItem) {
    self.dataStore?.commitChanges()
  }
  
  @objc private func cancelButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.controller(didTapCancelButton: sender)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}

extension FolderEditorViewController: FolderEditorDataStoreDelegate {
  func store(didErr error: Error) {
    print(error.localizedDescription)
  }
  
  func store(isModified: Bool) {
    self.commitButton.isEnabled = isModified
  }
}

extension FolderEditorViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TextInputCell.cellId, for: indexPath) as! TextInputCell
    cell.configure(folder: self.dataStore?.folder, delegate: self)
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "title".uppercased()
    } else {
      return nil
    }
  }
}

extension FolderEditorViewController: TextInputCellUpdating {
  func textDidChange(_ text: String) {
    self.dataStore?.updateFolderTitle(title: text)
  }
}
