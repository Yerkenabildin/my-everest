//
//  GoalsListViewModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 19.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
@testable import MyEverest

class GoalsListViewModelTest: XCTestCase {

  let disposeBag = DisposeBag()

  override func setUp() {
    super.setUp()
    setupGoalWithOneTask()
  }

  func testGoalsList() {
    var result: [Goal]?
    XCTAssertNil(result)
    XCTAssertNoThrow(result = try GoalsListViewModel().goalsObsrvable.toBlocking().first())
    XCTAssertEqual(result?.count, 1)
    setupGoalWithOneTask()
    XCTAssertNoThrow(result = try GoalsListViewModel().goalsObsrvable.toBlocking().first())
    XCTAssertEqual(result?.count, 2)
  }
}
