//
//  SearchResultsViewController.swift
//  gud-ios
//
//  Created by sudofluff on 9/25/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

protocol SearchResultsViewControllerDelegate: NSObjectProtocol {
  func searchResultsViewController(_ controller: SearchResultsViewController, didSelectResult result: SearchResult)
}

extension SearchResultsViewControllerDelegate {
  func searchResultsViewController(_ controller: SearchResultsViewController, didSelectResult result: SearchResult) {}
}

protocol SearchResultsViewControllerDataSource: NSObjectProtocol {
  func getSearchResults(withDescription description: String) -> [[SearchResult]]
}

class SearchResultsViewController: BaseViewController {
  weak var delegate: SearchResultsViewControllerDelegate?
  
  weak var dataSource: SearchResultsViewControllerDataSource?
  
  var resultList: [[SearchResult]] = []
  
  lazy private var tableView: UITableView = {
    let view = UITableView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self
    view.dataSource = self
    view.backgroundColor = CustomColor.clear
    view.separatorStyle = .none
    view.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
    view.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.cellId)
    view.rowHeight = UITableView.automaticDimension
    view.estimatedRowHeight = 44
    return view
  }()
  
  private func configureView() {
    self.view.backgroundColor = CustomColor.transparentBlack
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
    let result = self.resultList[indexPath.section][indexPath.row]
    cell.configure(searchResult: result)
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.resultList.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.resultList[section].count
  }
}

extension SearchResultsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedResult = self.resultList[indexPath.section][indexPath.row]
    self.delegate?.searchResultsViewController(self, didSelectResult: selectedResult)
  }
}

extension SearchResultsViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchString = searchController.searchBar.text else { return }
    if !searchString.isEmpty && searchString.count > 2 {
      guard let ds = self.dataSource else { return }
      self.resultList = ds.getSearchResults(withDescription: searchString)
      self.tableView.reloadData()
    }
  }
}
