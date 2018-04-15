//
//  GoalsListViewModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 19.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import MyEverest

class GoalsListViewModelTest: QuickSpec {
  var disposeBag: DisposeBag!
  var goals: [Goal] = []

  override func spec() {
    describe("GoalsListViewModel") {
      beforeEach {
        self.deleteAll()
        self.disposeBag = DisposeBag()
        GoalsListViewModel().goalsObsrvable
          .subscribe(onNext: { value in
            self.goals = value
          }).addDisposableTo(self.disposeBag)
      }

      it("Save") {
        expect(self.goals).toEventually(beEmpty())
        let goal = self.generateGoal()
        CoreDataModel.default.save(goal)
        expect(self.goals).toEventuallyNot(beEmpty())
        let goalFromDB = self.goals.first
        expect(goalFromDB?.name).toEventually(equal(goal.name))
      }

      it("Update") {
        expect(self.goals).toEventually(beEmpty())
        let goal = self.generateGoal()
        CoreDataModel.default.save(goal)
        expect(self.goals).toEventuallyNot(beEmpty())
        var goalFromDB = self.goals.first
        let newName = "newName"
        goalFromDB?.name = newName
        CoreDataModel.default.save(goalFromDB!)
        guard let object = goalFromDB else {
          return fail("nil object")
        }
        goalFromDB = CoreDataModel.default.fetch(object: object)
        expect(goalFromDB?.name).toEventually(equal(newName))
      }

      it("Delete") {
        expect(self.goals).toEventually(beEmpty())
        let goal = self.generateGoal()
        CoreDataModel.default.save(goal)
        expect(self.goals).toEventuallyNot(beEmpty())
        var goalFromDB = self.goals.first
        expect(goalFromDB).toEventuallyNot(beNil())
        expect(goalFromDB?.name).toEventually(equal(goal.name))
        CoreDataModel.default.delete(goalFromDB!)
        goalFromDB = CoreDataModel.default.fetchObjects()?.first
        expect(goalFromDB).toEventually(beNil())
      }
    }
  }
}

