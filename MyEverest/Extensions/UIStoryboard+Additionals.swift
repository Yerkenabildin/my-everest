//
//  Storyboard+Additionals.swift
//  Railways
//
//  Created by Yerkebulan Abildin on 20.07.17.
//  Copyright © 2017 Aviata. All rights reserved.
//

import UIKit

extension UIStoryboard {
  class func instantiate<T: UIViewController>(storyboard: String = StringConstants.mainStoryboardName) -> T {
    let identifier = String(describing: T.self)
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError(MyError.nilValue)
    }
    return viewController
  }
}
