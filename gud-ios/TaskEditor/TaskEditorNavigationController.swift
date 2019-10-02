//
//  TaskEditorNavigationController.swift
//  gud-ios
//
//  Created by sudofluff on 9/1/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

class TaskEditorNavigationController: BaseNavigationController {
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
