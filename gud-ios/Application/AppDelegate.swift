//
//  AppDelegate.swift
//  gud-ios
//
//  Created by sudofluff on 7/29/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import RealmSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  var appCoordinator: AppCoordinator?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let win = UIWindow(frame: UIScreen.main.bounds)
    win.makeKeyAndVisible()
    win.backgroundColor = CustomColor.black
    self.window = win
    
    let options = AppDependencyOptions(networkService: GudNetworkService())
    let ac = AppCoordinator(options: options, presenter: win)
    self.appCoordinator = ac
    self.appCoordinator?.start()
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }
}
