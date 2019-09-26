//
//  SearchResultsViewController.swift
//  gud-ios
//
//  Created by sudofluff on 9/25/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol SearchResultsViewControllerDelegate: NSObjectProtocol {
  func searchResultsViewController(_ controller: SearchResultsViewController, didSelectResult result: Any)
}

extension SearchResultsViewControllerDelegate {
  func searchResultsViewController(_ controller: SearchResultsViewController, didSelectResult result: Any) {}
}

protocol SearchResultsViewControllerDataSource: NSObjectProtocol {
  var resultList: [[Any]] { get }
}

class SearchResultsViewController: BaseViewController {
  weak var delegate: SearchResultsViewControllerDelegate?
  
  weak var dataSource: SearchResultsViewControllerDataSource?
  
  lazy private var tableView: UITableView = {
    let view = UITableView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self
    view.dataSource = self
    view.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.cellId)
    view.rowHeight = UITableView.automaticDimension
    view.estimatedRowHeight = 44
    return view
  }()
  
  private func configureView() {
    self.view.backgroundColor = CustomColor.clear
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

extension SearchResultsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.cellId, for: indexPath) as! SearchResultCell
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.dataSource?.resultList.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource?.resultList[section].count ?? 0
  }
}

extension SearchResultsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let selectedResult = self.dataSource?.resultList[indexPath.section][indexPath.row] else { return }
    self.delegate?.searchResultsViewController(self, didSelectResult: selectedResult)
  }
}

extension SearchResultsViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if let searchString = searchController.searchBar.text {
      if !searchString.isEmpty && searchString.count > 2 {
        // TODO: perform a fetch for matched items
      }
    }
  }
}
