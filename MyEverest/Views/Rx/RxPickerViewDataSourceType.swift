//
//  RxPickerViewDataSourceType.swift
//  BucketList
//
//  Created by  on 5/15/17.
//
//

import UIKit
import RxSwift
import RxCocoa

protocol RxPickerViewDataSourceType /*: UIPickerViewDataSource*/ {

  /// Type of elements that can be bound to picker view.
  associatedtype Element

  /// New observable sequence event observed.
  ///
  /// - parameter pickerView: Bound picker view.
  /// - parameter observedEvent: Event
  func pickerView(_ pickerView: UIPickerView, observedEvent: Event<Element>)
}
