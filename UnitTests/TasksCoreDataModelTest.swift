//
//  TasksCoreDataModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 02.09.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Quick
import Nimble
@testable import MyEverest

class TasksCoreDataModelTest: QuickSpec {
  var dataModel: DataModelProtocol!

  override func spec() {
    describe("CoreDataModel Task") {
      beforeEach {
        self.deleteAll()
        self.dataModel = CoreDataModel.default
      }

      it("Create two task and save only one") {
        _ = self.generateTask()
        let task = self.generateTask()
        self.dataModel.save(task)
        let tasks: [Task]? = self.dataModel.fetchObjects()
        expect(tasks?.count).to(equal(1))
      }

      it("Save") {
        let task = self.generateTask()
        self.dataModel.save(task)
        let taskFormDB: Task? = self.dataModel.fetch(object: task)
        expect(taskFormDB).toNot(beNil())
        expect(taskFormDB?.name).to(equal(task.name))
      }

      it("Update") {
        self.setupGoalWithOneTask()
        var taskFormDB: Task? = self.dataModel.fetchObjects()?.first
        expect(taskFormDB).toNot(beNil())
        let newName = "newName"
        taskFormDB?.name = newName
        self.dataModel.update(taskFormDB!)
        guard let object = taskFormDB else {
          return fail("nil object")
        }
        taskFormDB = self.dataModel.fetch(object: object)
        expect(taskFormDB?.name).to(equal(newName))
      }

      it("Delete") {
        let task = self.generateTask()
        self.dataModel.save(task)
        var taskFormDB: Task? = self.dataModel.fetchObjects()?.first
        expect(taskFormDB).toNot(beNil())
        expect(taskFormDB?.name).to(equal(task.name))
        self.dataModel.delete(taskFormDB!)
        taskFormDB = self.dataModel.fetchObjects()?.first
        expect(taskFormDB).to(beNil())
      }
    }
  }
}
