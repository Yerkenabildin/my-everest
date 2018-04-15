//
//  UIImagePickerController+Rx.swift
//  GoBiker-V2
//
//  Created by yerke on 23/03/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIImagePickerController {
  /**
   Reactive wrapper for `delegate` message.
   */
  public var didFinishPickingMediaWithInfo: Observable<[String : AnyObject]> {
    return delegate
      .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
      .map({ (a) in
        return try castOrThrow(Dictionary<String, AnyObject>.self, a[1])
      })
  }

  /**
   Reactive wrapper for `delegate` message.
   */
  public var didCancel: Observable<()> {
    return delegate
      .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:)))
      .map {_ in () }
  }
}

fileprivate func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
  guard let returnValue = object as? T else {
    throw RxCocoaError.castingError(object: object, targetType: resultType)
  }

  return returnValue
}
