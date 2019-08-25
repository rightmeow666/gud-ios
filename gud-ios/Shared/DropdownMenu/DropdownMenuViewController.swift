//
//  DropdownMenuViewController.swift
//  gud-ios
//
//  Created by sudofluff on 8/25/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol DropdownMenuViewControllerDataSource: NSObjectProtocol {
  var numberOfSections: Int { get }
  
  func dropdownMenuViewController(_ controller: DropdownMenuViewController, numberOfRowsInSection section: Int) -> Int
  
  func dropdownMenuViewController(_ controller: DropdownMenuViewController, titleForHeaderInSection section: Int) -> String?
  
  func dropdownMenuViewController(_ controller: DropdownMenuViewController, titleForRowAt indexPath: IndexPath) -> String
}

extension DropdownMenuViewControllerDataSource {
  var numberOfSections: Int { return 1 }
  
  func dropdownMenuViewController(_ controller: DropdownMenuViewController, titleForHeaderInSection section: Int) -> String? {
    return nil
  }
}

protocol DropdownMenuViewControllerDelegate: NSObjectProtocol {
  func dropdownMenuViewController(_ controller: DropdownMenuViewController, didSelectRowAt indexPath: IndexPath)
}

class DropdownMenuViewController: BaseViewController {
  weak var dataSource: DropdownMenuViewControllerDataSource?
  
  weak var delegate: DropdownMenuViewControllerDelegate?
  
  lazy private var tableView: UITableView = {
    let view = UITableView(frame: self.view.frame)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.rowHeight = UITableView.automaticDimension
    view.estimatedRowHeight = 44
    view.delegate = self
    view.dataSource = self
    return view
  }()
  
  private func configureView() {
    self.view.backgroundColor = .white
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

extension DropdownMenuViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.dataSource?.numberOfSections ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource?.dropdownMenuViewController(self, numberOfRowsInSection: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    let title = self.dataSource?.dropdownMenuViewController(self, titleForRowAt: indexPath)
    cell.textLabel?.text = title
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.dataSource?.dropdownMenuViewController(self, titleForHeaderInSection: section)
  }
}

extension DropdownMenuViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.delegate?.dropdownMenuViewController(self, didSelectRowAt: indexPath)
  }
}
