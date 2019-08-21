//
//  AppViewModel.swift
//  gud-ios
//
//  Created by sudofluff on 8/17/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import Foundation

class AppViewModel: NSObject {
  private var networkService: GudNetworkService
  
  weak var delegate: AppTabBarController?
  
  init(dependencyOptions: AppDependencyOptions, delegate: AppTabBarController) {
    self.networkService = dependencyOptions.networkService
    self.delegate = delegate
    super.init()
  }
}
