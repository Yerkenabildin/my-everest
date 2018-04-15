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
  var tintColor: Binder<UIColor> {
    return Binder(self.base) { navigationBar, tintColor in
      navigationBar.tintColor = tintColor
    }
  }

  var barTintColor: Binder<UIColor> {
    return Binder(self.base) { navigationBar, barTintColor in
      navigationBar.barTintColor = barTintColor
    }
  }
}
