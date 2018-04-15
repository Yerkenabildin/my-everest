//
//  TaskViewModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 14.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import RxSwift
import Quick
import Nimble
@testable import MyEverest

// TODO: - Add Tests
class TaskViewModelSpect: QuickSpec {
  let nameSubject = PublishSubject<String?>()
  let noteSubject = PublishSubject<String?>()
  let doneDateSubject = PublishSubject<Date?>()
  let deadlineDateSubject = PublishSubject<Date?>()
  let goalSubject = PublishSubject<Goal?>()
  let triggerSubject = PublishSubject<Void>()
  let disposeBag = DisposeBag()
  var callbackExpectation: XCTestExpectation!

  override func spec() {
    describe("Task ViewModel") {
      it("new task created") {

      }

      it("edit task") {

      }
    }
  }
}
