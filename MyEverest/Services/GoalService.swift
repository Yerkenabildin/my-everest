//
//  GoalService.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 15.04.18.
//  Copyright © 2018 abild.in. All rights reserved.
//

import Foundation
import RxSwift

protocol GoalServiceType {
  var goalsObservable: Observable<[Goal]> { get }
}

class GoalService: GoalServiceType {
  private(set) lazy var goalsObservable: Observable<[Goal]>  = {
    return Observable.of([])
  }()
}
