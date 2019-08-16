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
  
  var dataStore: FolderListDataStore?
  
  var networkService: GudNetworkService?
  
  lazy private var addButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    button.style = .done
    return button
  }()
  
  lazy private var cancelButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped(_:)))
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
      guard let store = self.dataStore else { return }
      store.deleteSelectedFolders()
      self.isEditing = false
    }
  }
  
  @objc private func cancelButtonTapped(_ sender: UIBarButtonItem) {
    if self.isEditing {
      self.isEditing = false
    }
  }
  
  @objc private func addButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.controller(didTapAddButton: sender)
  }
  
  @objc private func setEditMode(_ notification: Notification) {
    if let isEditing = notification.userInfo?["isEditing"] as? Bool {
      self.isEditing = isEditing
    }
  }
  
  private func configureView() {
    self.navigationItem.title = "Folder List"
    self.navigationItem.setRightBarButtonItems([self.addButton], animated: true)
    self.view.backgroundColor = CustomColor.white
    self.view.addSubview(self.collectionView)
    self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
    self.collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  private func observeEditModeNotification() {
    NotificationGrandeCentral.observeNotificationToEnableEditMode(self, selector: #selector(setEditMode(_:)))
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    self.collectionView.allowsMultipleSelection = isEditing
    // updating nav bar
    self.navigationItem.setRightBarButtonItems(editing ? [self.cancelButton] : [self.addButton], animated: true)
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
    self.dataStore?.getFolderList()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.observeEditModeNotification()
  }
}

extension FolderListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.dataStore?.folders?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCell.cellId, for: indexPath) as! FolderCell
    let folder = self.dataStore?.folders?[indexPath.item]
    cell.configure(folder: folder)
    return cell
  }
}

extension FolderListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let store = self.dataStore else { return }
    guard let selectedFolder = store.folders?[indexPath.item] else { return }
    if self.isEditing {
      store.appendSelectedFolder(selectedFolder: selectedFolder)
    } else {
      self.delegate?.controller(didSelectFolder: selectedFolder)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if self.isEditing {
      guard let store = self.dataStore else { return }
      guard let deselectedFolder = store.folders?[indexPath.item] else { return }
      if self.isEditing {
        store.removeDeselectedFolder(deselectedFolder: deselectedFolder)
      }
    }
  }
}

extension FolderListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if let folder = self.dataStore?.folders?[indexPath.item] {
      let titleWidth = collectionView.frame.width - 16 - 16 - 16 - 16
      let font = UIFont.preferredFont(forTextStyle: .body)
      let titleHeight = self.heightForView(text: folder.title, font: font, width: titleWidth)
      return CGSize(width: collectionView.frame.width, height: FolderCell.MINIMUM_HEIGHT + titleHeight)
    }
    return CGSize(width: collectionView.frame.width, height: FolderCell.MINIMUM_HEIGHT + 16)
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

extension FolderListViewController: FolderListDataStoreDelegate {
  func store(didErr error: Error) {
    print(error.localizedDescription)
  }
  
  func store(didGetFolderList list: Results<Folder>) {
    self.collectionView.reloadData()
  }
  
  func store(didUpdateFolderList list: Results<Folder>, deletedIndice: [Int], insertedIndice: [Int], updatedIndice: [Int]) {
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
