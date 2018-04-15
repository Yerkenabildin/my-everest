//
//  AppDelegate.swift
//  GoBiker-V2
//
//  Created by Nour Helmi on 11/02/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RxSwift
import PopupDialog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var disposeBag = DisposeBag()
    var coordinator: CoordinatorType?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
      launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        RxImagePickerDelegateProxy.register { RxImagePickerDelegateProxy(imagePicker: $0) }

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        Dependency.shared.initialize()

        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true

        // looks bad but works. This one will pass force unwrap :)
        self.coordinator = Dependency.shared.resolver.resolve(CoordinatorType.self)
        self.coordinator?.execute(step: AppStep.home)

        return true
    }
}
