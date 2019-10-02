//
//  FolderEditorNavigationController.swift
//  gud-ios
//
//  Created by sudofluff on 8/7/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class FolderEditorNavigationController: BaseNavigationController {
  private func configureView() {
    self.navigationBar.prefersLargeTitles = false
    self.navigationBar.backgroundColor = CustomColor.black
    self.navigationBar.isTranslucent = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}
