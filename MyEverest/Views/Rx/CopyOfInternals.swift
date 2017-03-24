//
//  ObservableType.swift
//  BucketList
//
//  Created by  on 5/15/17.
//
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - copy from RxSwift internal functions
extension ObservableType {
  func subscribeProxyDataSource<P: DelegateProxyType>(ofObject object: UIView,
                                                      dataSource: AnyObject,
                                                      retainDataSource: Bool,
                                                      binding: @escaping (P, Event<E>) -> Void) -> Disposable {
    let proxy = P.proxyForObject(object)
    let unregisterDelegate = P.installForwardDelegate(dataSource,
      retainDelegate: retainDataSource, onProxyForObject: object)
    object.layoutIfNeeded()

    let subscription = self.asObservable()
      .observeOn(MainScheduler())
      .catchError { error in
        print(error)
        return Observable.empty()
      }.concat(Observable.never())
      .takeUntil(object.rx.deallocated)
      .subscribe { (event: Event<E>) in

        binding(proxy, event)
        switch event {
        case .error(let error):
          print(error)
          unregisterDelegate.dispose()
        case .completed:
          unregisterDelegate.dispose()
        default:
          break
        }
    }

    return Disposables.create { [weak object] in
      subscription.dispose()
      object?.layoutIfNeeded()
      unregisterDelegate.dispose()
    }
  }
}

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
  guard let returnValue = object as? T else {
    throw RxCocoaError.castingError(object: object, targetType: resultType)
  }

  return returnValue
}

func castOptionalOrFatalError<T>(_ value: Any?) -> T? {
  if value == nil {
    return nil
  }
  let v: T = castOrFatalError(value)
  return v
}

func castOrFatalError<T>(_ value: Any!) -> T {
  let maybeResult: T? = value as? T
  guard let result = maybeResult else {
    fatalError("Failure converting from \(value) to \(T.self)")
  }

  return result
}

var dataSourceAssociatedTag: UnsafeRawPointer = UnsafeRawPointer(UnsafeMutablePointer<UInt8>.allocate(capacity: 1))
