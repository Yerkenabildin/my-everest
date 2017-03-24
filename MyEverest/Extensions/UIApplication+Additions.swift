//
//  UIApplication +Additions.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 13.05.17.
//
//

import UIKit
import RxSwift
import RxCocoa

extension UIApplication {
  class func topViewController(controller: UIViewController? =
    UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
      return topViewController(controller: navigationController.visibleViewController)
    } else if let tabController = controller as? UITabBarController,
      let selected = tabController.selectedViewController {
      return topViewController(controller: selected)
    } else if let presented = controller?.presentedViewController {
      return topViewController(controller: presented)
    }
    return controller
  }
}
