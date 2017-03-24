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
  var image: UIBindingObserver<Base, UIImage> {
    return UIBindingObserver(UIElement: self.base) { button, image in
      button.imageView?.image = image
    }
  }

  var tintColor: UIBindingObserver<Base, UIColor> {
    return UIBindingObserver(UIElement: self.base) { button, tintColor in
      button.tintColor = tintColor
    }
  }

  var backgroundColor: UIBindingObserver<Base, UIColor> {
    return UIBindingObserver(UIElement: self.base) { button, backgroundColor in
      button.backgroundColor = backgroundColor
    }
  }
}
