//
//  FolderListViewController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit
import RealmSwift

class FolderListViewController: BaseViewController {
  weak var delegate: FolderListViewControllerDelegate?
  
  var viewModel: FolderListViewModel!
  
  lazy private var addButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    button.style = .done
    return button
  }()
  
  lazy private var cancelButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped(_:)))
    return button
  }()
  
  lazy private var editButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped(_:)))
    return button
  }()
  
  lazy private var deleteButton: UIBarButtonItem = {
    let button = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteButtonTapped(_:)))
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
  
  @objc private func deleteButtonTapped(_ sender: UIBarButtonItem) {
    if self.isEditing {
      self.viewModel.deleteSelectedFolders()
      self.isEditing = false
    }
  }
  
  @objc private func editButtonTapped(_ sender: UIBarButtonItem) {
    if !self.isEditing {
      self.isEditing = true
    }
  }
  
  @objc private func cancelButtonTapped(_ sender: UIBarButtonItem) {
    if self.isEditing {
      self.isEditing = false
    }
  }
  
  @objc private func addButtonTapped(_ sender: UIBarButtonItem) {
    if !self.isEditing {
      self.delegate?.folderListViewController(self, didTapAddButton: sender)
    }
  }
  
  @objc private func setEditMode(_ notification: Notification) {
    if let isEditing = notification.userInfo?["isEditing"] as? Bool {
      self.isEditing = isEditing
    }
  }
  
  private func configureView() {
    self.navigationItem.title = "Folder List"
    self.navigationItem.setRightBarButtonItems([self.addButton, self.editButton], animated: true)
    self.view.backgroundColor = CustomColor.white
    self.view.addSubview(self.collectionView)
    self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
    self.collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    self.collectionView.allowsMultipleSelection = isEditing
    // updating nav bar
    self.navigationItem.setRightBarButtonItems(editing ? [self.cancelButton] : [self.addButton, self.editButton], animated: true)
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    NotificationGrandeCentral.observeNotificationToEnableEditMode(self, selector: #selector(setEditMode(_:)))
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
  func viewModel(_ vm: FolderListViewModel, didErr error: Error) {
    print(error.localizedDescription)
  }
  
  func viewModel(_ vm: FolderListViewModel, didGetFolderList list: Results<Folder>) {
    self.collectionView.reloadData()
  }
  
  func viewModel(_ vm: FolderListViewModel, didUpdateFolderList list: Results<Folder>, deletedIndice: [Int], insertedIndice: [Int], updatedIndice: [Int]) {
    let ops = BlockOperation {
      let dis = deletedIndice.map({ IndexPath(item: $0, section: 0) })
      let iis = insertedIndice.map({ IndexPath(item: $0, section: 0) })
      let uis = updatedIndice.map({ IndexPath(item: $0, section: 0) })
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
