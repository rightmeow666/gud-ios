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
  
  lazy var addButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    return button
  }()
  
  lazy var editButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped(_:)))
    return button
  }()
  
  lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: self.view.frame, collectionViewLayout: self.flowLayout)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.cellId)
    view.alwaysBounceVertical = true
    view.scrollsToTop = true
    view.backgroundColor = CustomColor.white
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
  
  @objc func editButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.controller(didTapEditButton: sender)
  }
  
  @objc func addButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.controller(didTapAddButton: sender)
  }
  
  func configureView() {
    self.navigationItem.rightBarButtonItems = [addButton, editButton]
    self.view.addSubview(self.collectionView)
    self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}

extension TaskListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.dataStore?.tasks[section].count ?? 0
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.dataStore?.tasks.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCell.cellId, for: indexPath) as! TaskCell
    return cell
  }
}

extension TaskListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.delegate?.controller(didSelectItemAt: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    self.delegate?.controller(didDeselectItemAt: indexPath)
  }
}

extension TaskListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 180)
  }
}
