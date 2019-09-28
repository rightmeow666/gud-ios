//
//  FolderListViewController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit
import RealmSwift

protocol FolderListViewControllerDelegate: NSObjectProtocol {
  func folderListViewController(_ controller: FolderListViewController, didSelectAddOptionOnSourceView sourceView: UIBarButtonItem)
  
  func folderListViewController(_ controller: FolderListViewController, didSelectFolder folder: Folder)
  
  func folderListViewController(_ controller: FolderListViewController, didTapMoreButton button: UIBarButtonItem)
}

class FolderListViewController: BaseViewController {
  weak var delegate: FolderListViewControllerDelegate?
  
  var viewModel: FolderListViewModel!
  
  lazy private var searchResultsViewController: SearchResultsViewController = {
    let controller = SearchResultsViewController()
    controller.delegate = self
    controller.dataSource = self
    return controller
  }()
  
  lazy private var moreButton: UIBarButtonItem = {
    let button = UIBarButtonItem(image: UIImage(named: "More"), style: .plain, target: self, action: #selector(self.moreButtonTapped(_:)))
    return button
  }()
  
  lazy private var cancelButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelButtonTapped(_:)))
    return button
  }()
  
  lazy private var deleteButton: UIBarButtonItem = {
    let button = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(self.deleteButtonTapped(_:)))
    return button
  }()
  
  lazy private var collectionView: UICollectionView = {
    let view = UICollectionView(frame: self.view.frame, collectionViewLayout: self.flowLayout)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.register(FolderCell.self, forCellWithReuseIdentifier: FolderCell.cellId)
    view.alwaysBounceVertical = true
    view.scrollsToTop = true
    view.backgroundColor = CustomColor.white
    view.allowsMultipleSelection = false
    view.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    view.delegate = self
    view.dataSource = self
    return view
  }()
  
  lazy private var flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    return layout
  }()
  
  @objc private func moreButtonTapped(_ sender: UIBarButtonItem) {
    if !self.isEditing {
      self.delegate?.folderListViewController(self, didTapMoreButton: sender)
    }
  }
  
  @objc private func deleteButtonTapped(_ sender: UIBarButtonItem) {
    if self.isEditing {
      self.viewModel.deleteSelectedFolders()
    }
  }
  
  @objc private func cancelButtonTapped(_ sender: UIBarButtonItem) {
    if self.isEditing {
      self.isEditing = false
    }
  }
  
  private func configureView() {
    self.navigationItem.title = "Folder List"
    self.navigationItem.setRightBarButtonItems([self.moreButton], animated: true)
    self.view.backgroundColor = CustomColor.white
    
    self.view.addSubview(self.collectionView)
    self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
    self.collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    self.navigationItem.searchController = UISearchController(searchResultsController: self.searchResultsViewController)
    self.navigationItem.searchController?.searchResultsUpdater = self.searchResultsViewController
    self.navigationItem.searchController?.searchBar.barStyle = .black
    self.navigationItem.searchController?.searchBar.tintColor = CustomColor.mandarinOrange
    self.navigationItem.searchController?.searchBar.keyboardAppearance = .dark
    self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = true
    self.navigationItem.hidesSearchBarWhenScrolling = true
    self.definesPresentationContext = true
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    self.collectionView.allowsMultipleSelection = isEditing
    // updating nav bar
    self.navigationItem.setRightBarButtonItems(editing ? [self.cancelButton] : [self.moreButton], animated: true)
    self.navigationItem.setLeftBarButtonItems(editing ? [self.deleteButton] : [], animated: true)
    // updating cells
    for indexPath in self.collectionView.indexPathsForVisibleItems {
      self.collectionView.deselectItem(at: indexPath, animated: false)
      if let cell = self.collectionView.cellForItem(at: indexPath) as? FolderCell {
        cell.isEditing = isEditing
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
    self.viewModel.getFolderList()
  }
}

extension FolderListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.viewModel.getNumberOfItems(inSection: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCell.cellId, for: indexPath) as! FolderCell
    let folder = self.viewModel.getFolder(atIndexPath: indexPath)
    cell.configure(folder: folder)
    return cell
  }
}

extension FolderListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if self.isEditing {
      self.viewModel.selectFolder(atIndexPath: indexPath)
    } else {
      guard let folder = self.viewModel.getFolder(atIndexPath: indexPath) else { return }
      self.delegate?.folderListViewController(self, didSelectFolder: folder)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if self.isEditing {
      self.viewModel.deselectFolder(atIndexPath: indexPath)
    }
  }
}

extension FolderListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if let folder = self.viewModel.getFolder(atIndexPath: indexPath) {
      let titleWidth = collectionView.frame.width - 16 - 16 - 16 - 16
      let font = UIFont.preferredFont(forTextStyle: .body)
      let titleHeight = self.heightForView(text: folder.title, font: font, width: titleWidth)
      return CGSize(width: collectionView.frame.width, height: FolderCell.MINIMUM_HEIGHT + titleHeight)
    } else {
      return CGSize(width: collectionView.frame.width, height: FolderCell.MINIMUM_HEIGHT + 16)
    }
  }
  
  private func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    return label.frame.height
  }
}

extension FolderListViewController: FolderListViewModelDelegate {
  func shouldUpdateEditMode(_ vm: FolderListViewModel, isEditing: Bool) {
    self.isEditing = isEditing
  }
  
  func didGetFolderList(_ vm: FolderListViewModel) {
    self.collectionView.reloadData()
  }
  
  func viewModel(_ vm: FolderListViewModel, didErr error: Error) {
    self.presentAlert(error.localizedDescription, alertType: .error, completion: nil)
  }
  
  func viewModel(_ vm: FolderListViewModel, deletedIndice: [Int], insertedIndice: [Int], modifiedIndice: [Int]) {
    let ops = BlockOperation {
      let dis = deletedIndice.map({ IndexPath(item: $0, section: 0) })
      let iis = insertedIndice.map({ IndexPath(item: $0, section: 0) })
      let uis = modifiedIndice.map({ IndexPath(item: $0, section: 0) })
      self.collectionView.deleteItems(at: dis)
      self.collectionView.insertItems(at: iis)
      self.collectionView.reloadItems(at: uis)
    }
    self.collectionView.performBatchUpdates({
      ops.start()
    }) { (completed) in
      self.collectionView.scrollsToTop()
    }
  }
}

extension FolderListViewController: DropdownMenuViewControllerDelegate {
  func dropdownMenuViewController(_ controller: DropdownMenuViewController, didSelectRowAt indexPath: IndexPath) {
    guard let selectedOption = self.viewModel.getSelectedMenuOption(atIndex: indexPath.item) else { return }
    switch selectedOption {
    case .Edit:
      if !self.isEditing {
        controller.dismiss(animated: true) {
          self.isEditing = true
        }
      }
    case .New:
      controller.dismiss(animated: true) {
        self.delegate?.folderListViewController(self, didSelectAddOptionOnSourceView: self.moreButton)
      }
    }
  }
}

extension FolderListViewController: DropdownMenuViewControllerDataSource {
  func dropdownMenuViewController(_ controller: DropdownMenuViewController, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.getNumberOfMenuOptions(inSection: section)
  }
  
  func dropdownMenuViewController(_ controller: DropdownMenuViewController, titleForRowAt indexPath: IndexPath) -> String {
    return self.viewModel.getTitleOfMenuOptions(atIndex: indexPath.item) ?? ""
  }
}

extension FolderListViewController: SearchResultsViewControllerDelegate {
  func searchResultsViewController(_ controller: SearchResultsViewController, didSelectResult result: SearchResult) {
    pp(result)
  }
}

extension FolderListViewController: SearchResultsViewControllerDataSource {
  func getSearchResults(withDescription description: String) -> [[SearchResult]] {
    return self.viewModel.searchFolders(byTitle: description)
  }
}
