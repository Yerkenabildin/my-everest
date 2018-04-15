//
//  Observable+Extension.swift
//  GoBiker-V2
//
//  Created by Nour Helmi on 19/02/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {

  func catchErrorJustComplete() -> Observable<E> {
    return catchError { _ in
      return Observable.empty()
    }
  }

  func asDriverOnErrorJustComplete() -> Driver<E> {
    return asDriver { _ in
      return Driver.empty()
    }
  }

  func mapVoid() -> Observable<()> {
    return map { _ in return }
  }
}

extension ObservableType {
  func asCompletable() -> Completable {
    return ignoreElements()
  }
}

extension PrimitiveSequence where Trait == SingleTrait {
  func asCompletable() -> Completable {
    return asObservable().asCompletable()
  }
}

extension PrimitiveSequence where Trait == MaybeTrait {
  func asCompletable() -> Completable {
    return asObservable().asCompletable()
  }
}
