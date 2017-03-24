//
//  RxCollectionViewDataSourceProxy.swift
//  BucketList
//
//  Created by  on 5/15/17.
//
//

import UIKit
import RxSwift
import RxCocoa

let dataSourceNotSet = "DataSource not set"

let pickerViewDataSourceNotSet = PickerViewDataSourceNotSet()

final class PickerViewDataSourceNotSet: NSObject, PickerViewReactiveDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
   return 0
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return nil
  }
}

class RxPickerViewDataSourceProxy: DelegateProxy,
  PickerViewReactiveDelegate, DelegateProxyType {

  weak private(set) var pickerView: UIPickerView?

  private weak var _requiredMethodsDataSource: PickerViewReactiveDelegate?
    = pickerViewDataSourceNotSet

  required init(parentObject: AnyObject) {
    self.pickerView = castOrFatalError(parentObject)
    super.init(parentObject: parentObject)
  }

  // MARK: DataSource
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return (_requiredMethodsDataSource ?? pickerViewDataSourceNotSet).numberOfComponents(in: pickerView)
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return (_requiredMethodsDataSource ?? pickerViewDataSourceNotSet)
      .pickerView(pickerView, numberOfRowsInComponent: component)
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return (_requiredMethodsDataSource ?? pickerViewDataSourceNotSet)
      .pickerView?(pickerView, titleForRow: row, forComponent: component)
  }

  // MARK: proxy
  override class func createProxyForObject(_ object: AnyObject) -> AnyObject {
    let pickerView: UIPickerView = castOrFatalError(object)
    return RxPickerViewDataSourceProxy(parentObject: pickerView)
  }

  /// For more information take a look at `DelegateProxyType`.
  override class func delegateAssociatedObjectTag() -> UnsafeRawPointer {
    return dataSourceAssociatedTag
  }

  /// For more information take a look at `DelegateProxyType`.
  class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
    let pickerView: UIPickerView = castOrFatalError(object)
    pickerView.dataSource = castOptionalOrFatalError(delegate)
    pickerView.delegate = castOptionalOrFatalError(delegate)
  }

  /// For more information take a look at `DelegateProxyType`.
  class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
    let pickerView: UIPickerView = castOrFatalError(object)
    return pickerView.dataSource
  }

  /// For more information take a look at `DelegateProxyType`.
  override func setForwardToDelegate(_ forwardToDelegate: AnyObject?, retainDelegate: Bool) {
    let requiredMethodsDataSource: PickerViewReactiveDelegate?
      = castOptionalOrFatalError(forwardToDelegate)
    _requiredMethodsDataSource = requiredMethodsDataSource ?? pickerViewDataSourceNotSet
    super.setForwardToDelegate(forwardToDelegate, retainDelegate: retainDelegate)
  }
}
