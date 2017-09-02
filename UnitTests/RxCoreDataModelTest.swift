//
//  RxCoreDataTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 02.09.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking
@testable import MyEverest

class RxCoreDataModelTest: QuickSpec {

  var disposeBag: DisposeBag!
  var dataModel: DataModelProtocol!

  override func spec() {
    describe("RxCoreDataModel") {

      beforeEach {
        self.deleteAll()
        self.disposeBag = DisposeBag()
        self.dataModel = CoreDataModel.default
      }

      describe("Objects array") {
        var goals: [Goal] = []
        var goalsObservable: Observable<[Goal]>!

        beforeEach {
          goalsObservable = self.dataModel.rxFetchObjects(predicate: nil)
          goalsObservable.subscribe(onNext: { value in
            goals = value
          }).addDisposableTo(self.disposeBag)
        }

        it("Save") {
          expect(goals).toEventually(beEmpty())
          let goal = self.generateGoal()
          self.dataModel.save(goal)
          expect(goals).toEventuallyNot(beEmpty())
          let goalFromDB = goals.first
          expect(goalFromDB?.name).toEventually(equal(goal.name))
        }

        it("Update") {
          expect(goals).toEventually(beEmpty())
          let goal = self.generateGoal()
          self.dataModel.save(goal)
          expect(goals).toEventuallyNot(beEmpty())
          var goalFromDB = goals.first
          let newName = "newName"
          goalFromDB?.name = newName
          self.dataModel.update(goalFromDB!)
          guard let object = goalFromDB else {
            return fail("nil object")
          }
          goalFromDB = self.dataModel.fetch(object: object)
          expect(goalFromDB?.name).toEventually(equal(newName))
        }

        it("Delete") {
          expect(goals).toEventually(beEmpty())
          let goal = self.generateGoal()
          self.dataModel.save(goal)
          expect(goals).toEventuallyNot(beEmpty())
          var goalFromDB = goals.first
          expect(goalFromDB).toEventuallyNot(beNil())
          expect(goalFromDB?.name).toEventually(equal(goal.name))
          self.dataModel.delete(goalFromDB!)
          goalFromDB = self.dataModel.fetchObjects()?.first
          expect(goalFromDB).toEventually(beNil())
        }
      }

      describe("One object") {
        var goal: Goal!
        var goalsObservable: Observable<Goal?>!

        beforeEach {
          goal = self.generateGoal()
          self.dataModel.save(goal)
          goalsObservable = self.dataModel.rxFetch(object: goal)
        }

        it("Update") {
          expect(goal).toNot(beNil())
          goal.name = "newName"
          self.dataModel.save(goal!)
          let goalFromDB: Goal? =  try! goalsObservable.toBlocking().first() as? Goal
          expect(goalFromDB?.name).to(equal(goal.name))
        }

        it("Delete") {
          expect(goal).toNot(beNil())
          self.dataModel.delete(goal!)
          let goalFromDB: Goal? =  try! goalsObservable.toBlocking().first() as? Goal
          expect(goalFromDB).to(beNil())
        }
      }
    }
  }
}
