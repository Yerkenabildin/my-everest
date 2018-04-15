//
//  UIView+Additions.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 13.05.17.
//
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
  var backgroundColor: Binder<UIColor> {
    return Binder(self.base) { view, backgroundColor in
      view.backgroundColor = backgroundColor
    }
  }
}
