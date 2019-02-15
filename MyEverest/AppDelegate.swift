//
//  AppDelegate.swift
//  GoBiker-V2
//
//  Created by Nour Helmi on 11/02/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//
import UIKit
import IQKeyboardManagerSwift
import RxFlow
import RxSwift
import PopupDialog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private var disposeBag = DisposeBag()
  var coordinator = Coordinator()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    RxImagePickerDelegateProxy.register { RxImagePickerDelegateProxy(imagePicker: $0) }
    Dependency.shared.initialize()

    // Override point for customization after application launch.
    IQKeyboardManager.shared.enable = true
    IQKeyboardManager.shared.shouldResignOnTouchOutside = true

    guard let window = self.window else {
      return false
    }

    let appFlow = AppFlow(with: window)
    coordinator.coordinate(flow: appFlow, withStepper: OneStepper(withSingleStep: AppStep.home))

    return true
  }
}
