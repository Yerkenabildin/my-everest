//
//  UINavigationBar+Additions.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 15.05.17.
//
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UINavigationBar {
  var tintColor: UIBindingObserver<Base, UIColor> {
    return UIBindingObserver(UIElement: self.base) { navigationBar, tintColor in
      navigationBar.tintColor = tintColor
    }
  }

  var barTintColor: UIBindingObserver<Base, UIColor> {
    return UIBindingObserver(UIElement: self.base) { navigationBar, barTintColor in
      navigationBar.barTintColor = barTintColor
    }
  }
}
