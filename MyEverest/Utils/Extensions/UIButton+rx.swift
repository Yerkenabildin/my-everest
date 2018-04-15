//
//  UIButton+Additions.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 15.05.17.
//
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {
  var image: Binder<UIImage> {
    return Binder(self.base) { button, image in
      button.imageView?.image = image
    }
  }

  var tintColor: Binder<UIColor> {
    return Binder(self.base) { button, tintColor in
      button.tintColor = tintColor
    }
  }

  var backgroundColor: Binder<UIColor> {
    return Binder(self.base) { button, backgroundColor in
      button.backgroundColor = backgroundColor
    }
  }
}
