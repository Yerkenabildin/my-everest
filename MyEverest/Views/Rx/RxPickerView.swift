//
//  UIPickerView+rx.swift
//  BucketList
//
//  Created by  on 5/15/17.
//
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIPickerView {

  func rows<S: Sequence, O: ObservableType> ()
    -> (_ source: O)
    -> (_ titleFactory: @escaping (UIPickerView, Int, S.Iterator.Element) -> String)
    -> Disposable
    where O.E == S {
      return { source in
        return { titleFactory in
          let dataSource = RxPickerViewDataSourceSequenceWrapper<S>(titleFactory: titleFactory)
          return self.rows(dataSource: dataSource)(source)
        }
      }
  }

  private func rows<DataSource: RxPickerViewDataSourceType & PickerViewReactiveDelegate, O: ObservableType>
    (dataSource: DataSource)
    -> (_ source: O)
    -> Disposable
    where DataSource.Element == O.E {
      return { source in
        _ = self.delegate
        return source
          .subscribeProxyDataSource(ofObject: self.base,
          dataSource:dataSource,
          retainDataSource: true) { [weak pickerView = self.base] (_: RxPickerViewDataSourceProxy, event) -> Void in
            guard let pickerView = pickerView else {
              return
            }
            dataSource.pickerView(pickerView, observedEvent: event)
          }
      }
  }
}
