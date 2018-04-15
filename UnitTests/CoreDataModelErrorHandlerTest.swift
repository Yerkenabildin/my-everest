//
//  CoreDataModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 02.09.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Quick
import Nimble
import CoreData
@testable import MyEverest

class CoreDataModelErrorHandlerTest: QuickSpec {

  override func spec() {
    describe("CoreDataModel") {

      beforeEach {
        self.deleteAll()
      }

      it("Delete exeption handler") {
        expect { () -> Void in
          let goal = self.generateGoal()
          CoreDataModel.default.delete(goal)
        }.toNot(raiseException())
      }

      it("Get entits with unknow  name") {
        expect { () -> Void in
          let _ = CoreDataModel.default.entityForName("DummyName")
        }.to(throwAssertion())
      }

      describe("Unknow objects") {
        it("Fetch") {
          expect { () -> Void in
            let _: [NSManagedObject]? = CoreDataModel.default.fetchObjects()
          }.to(raiseException())
        }

        it("Delete") {
          expect { () -> Void in
            CoreDataModel.default.delete(allObjectOf: NSManagedObject.self)
          }.to(raiseException())
        }
      }
    }
  }
}
