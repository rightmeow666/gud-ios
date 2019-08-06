//
//  TaskListViewController.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskListViewController: BaseViewController {
  weak var delegate: TaskListViewControllerDelegate?
  
  var dataStore: TaskListDataStore?
  
  var networkService: GudNetworkService?
  
  lazy var addButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    return button
  }()
  
  lazy var cancelButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped(_:)))
    return button
  }()
  
  lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: self.view.frame, collectionViewLayout: self.flowLayout)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.cellId)
    view.alwaysBounceVertical = true
    view.scrollsToTop = true
    view.backgroundColor = CustomColor.white
    view.allowsMultipleSelection = false
    view.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    view.delegate = self
    view.dataSource = self
    return view
  }()
  
  lazy var flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    return layout
  }()
  
  @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
    if self.isEditing {
      self.isEditing = false
    }
  }
  
  @objc func addButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.controller(didTapAddButton: sender)
  }
  
  @objc func setEditMode(_ notification: Notification) {
    if let isEditing = notification.userInfo?["isEditing"] as? Bool {
      self.isEditing = isEditing
    }
  }
  
  private func configureView() {
    self.navigationItem.title = "why brother? why?"
    self.navigationItem.rightBarButtonItems = [self.addButton]
    self.view.addSubview(self.collectionView)
    self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
    self.collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  private func observeEditModeNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(setEditMode(_:)), name: NSNotification.Name.EditMode, object: nil)
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    self.collectionView.allowsMultipleSelection = isEditing
    let indexPaths = self.collectionView.indexPathsForVisibleItems
    // updating nav bar
    self.navigationItem.setRightBarButtonItems(editing ? [self.cancelButton] : [self.addButton], animated: true)
    // updating cells
    for indexPath in indexPaths {
      self.collectionView.deselectItem(at: indexPath, animated: false)
      if let cell = self.collectionView.cellForItem(at: indexPath) as? TaskCell {
        cell.isEditing = isEditing
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.observeEditModeNotification()
  }
}

extension TaskListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.dataStore?.pendingTasks.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCell.cellId, for: indexPath) as! TaskCell
    let task = self.dataStore?.pendingTasks[indexPath.item]
    cell.configure(task: task)
    return cell
  }
}

extension TaskListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if self.isEditing {
      // TODO: implement this
    } else {
      self.delegate?.controller(didSelectItemAt: indexPath)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    // TODO: implement this
  }
}

extension TaskListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if let task = self.dataStore?.pendingTasks[indexPath.item] {
      let titleWidth = collectionView.frame.width - 16 - 16 - 16 - 16
      let font = UIFont.preferredFont(forTextStyle: .body)
      let titleHeight = heightForView(text: task.title, font: font, width: titleWidth)
      return CGSize(width: collectionView.frame.width, height: TaskCell.minimumHeight + titleHeight)
    }
    return CGSize(width: collectionView.frame.width, height: TaskCell.minimumHeight + 16)
  }
}
