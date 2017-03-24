//
//  AppDelegate.swift
//  BucketList
//
//  Created by  on 3/24/17.
//
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    IQKeyboardManager.sharedManager().enable = true
    IQKeyboardManager.sharedManager().toolbarTintColor = ColorConstants.tintColor
    IQKeyboardManager.sharedManager().toolbarPreviousNextAllowedClasses.append(IQKeyboardEnableView.self)
    UIApplication.shared.statusBarStyle = .lightContent
    return true
  }
}
