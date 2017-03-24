//
//  RxPickerViewReactiveArrayDataSource.swift
//  BucketList
//
//  Created by  on 5/15/17.
//
//

import UIKit
import RxSwift
import RxCocoa

typealias PickerViewReactiveDelegate = (UIPickerViewDataSource & UIPickerViewDelegate)

class PickerViewArrayDataSource: NSObject, PickerViewReactiveDelegate {

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

class RxPickerViewDataSourceSequenceWrapper<S: Sequence>
  : RxPickerViewReactiveArrayDataSource<S.Iterator.Element>, RxPickerViewDataSourceType {
  typealias Element = S

  override init(titleFactory: @escaping TitleFactory) {
    super.init(titleFactory: titleFactory)
  }

  func pickerView(_ pickerView: UIPickerView, observedEvent: Event<S>) {
    UIBindingObserver(UIElement: self) { pickerViewViewDataSource, elements in
      let elements = Array(elements)
      pickerViewViewDataSource.pickerView(pickerView, observedElements: elements)
      }.on(observedEvent)
  }
}

class RxPickerViewReactiveArrayDataSource<Element>: PickerViewArrayDataSource {

  typealias TitleFactory = (UIPickerView, Int, Element) -> String

  var titleFactory: TitleFactory

  init(titleFactory: @escaping TitleFactory) {
    self.titleFactory = titleFactory
  }

  var itemModels: [Element]?

  func modelAtIndex(row: Int, component: Int) -> Element? {
    return itemModels?[row]
  }

  // data source
  override func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return itemModels?.count ?? 0
  }

  override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return titleFactory(pickerView, row, itemModels![row])
  }

  // reactive
  func pickerView(_ pickerView: UIPickerView, observedElements: [Element]) {
    self.itemModels = observedElements
    pickerView.reloadAllComponents()
  }
}
