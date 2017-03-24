//
//  CommonColorPickerView+rx.swift
//  BucketList
//
//  Created by  on 5/17/17.
//
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: CommonColorPickerView {
  var selectedColor: ControlProperty<UIColor?> {
    return UIControl.rx.valuePublic(
      self.base,
      getter: { colorPickerView in
        colorPickerView.selectedColor
    }, setter: { colorPickerView, value in
      colorPickerView.selectedColor = value
    })
  }

  var colors: ControlProperty<[UIColor]?> {
    return UIControl.rx.valuePublic(
      self.base,
      getter: { colorPickerView in
        colorPickerView.colors
    }, setter: { colorPickerView, value in
      colorPickerView.colors = value
    })
  }

  var preselectedIndex: UIBindingObserver<Base, Int?> {
    return UIBindingObserver(UIElement: self.base) { colorPickerView, preselectedIndex in
      colorPickerView.preselectedIndex = preselectedIndex
    }
  }
}
