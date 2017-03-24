//
//  GoalsListViewModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 19.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import XCTest
import RxSwift
@testable import MyEverest

class GoalsListViewModelTest: XCTestCase {

  var goalsListExpectation: XCTestExpectation!
  let disposeBag = DisposeBag()

  override func setUp() {
    super.setUp()
    setupGoalWithOneTask()
    self.goalsListExpectation = expectation(description: "Callback is successful")
  }

  func testGoalsList() {
    GoalsListViewModel().goalsObsrvable.asObservable()
      .subscribe(onNext: { goals in
        XCTAssertEqual(goals.count, 1)
        self.goalsListExpectation.fulfill()
      }).addDisposableTo(self.disposeBag)

    waitForExpectations(timeout: 5.0) {error in
      XCTAssertNil(error)
    }
  }
}
