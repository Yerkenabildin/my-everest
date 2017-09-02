//
//  LocalStorageModelTest.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 13.08.17.
//
//

import Quick
import Nimble
@testable import MyEverest

class GoalsCoreDataModelTest: QuickSpec {
  var dataModel: DataModelProtocol!

  override func spec() {
    describe("CoreDataModel Goal") {
      beforeEach {
        self.deleteAll()
        self.dataModel = CoreDataModel.default
      }

      it("Create without saving") {
        _ = self.generateGoal()
        let goal = self.generateGoal()
        self.dataModel.save(goal)
        let goals: [Goal]? = self.dataModel.fetchObjects()
        expect(goals?.count).to(equal(1))
      }

      it("Save") {
        let goal = self.generateGoal()
        self.dataModel.save(goal)
        let goalFormDB: Goal? = self.dataModel.fetch(object: goal)
        expect(goalFormDB).toNot(beNil())
        expect(goalFormDB?.name).to(equal(goal.name))
      }

      it("Update") {
        self.setupGoalWithOneTask()
        var goalFormDB: Goal? = self.dataModel.fetchObjects()?.first
        expect(goalFormDB).toNot(beNil())
        let newName = "newName"
        goalFormDB?.name = newName
        self.dataModel.update(goalFormDB!)
        guard let object = goalFormDB else {
           return fail("nil object")
        }
        goalFormDB = self.dataModel.fetch(object: object)
        expect(goalFormDB?.name).to(equal(newName))
      }

      it("Delete") {
        let goal = self.generateGoal()
        self.dataModel.save(goal)
        var goalFormDB: Goal? = self.dataModel.fetchObjects()?.first
        expect(goalFormDB).toNot(beNil())
        expect(goalFormDB?.name).to(equal(goal.name))
        self.dataModel.delete(goalFormDB!)
        goalFormDB = self.dataModel.fetchObjects()?.first
        expect(goalFormDB).to(beNil())
      }

      it("Save with tasks") {
        let goal = self.generateGoal()
        self.dataModel.save(goal)
        let task1 = self.generateTask()
        let task2 = self.generateTask()
        goal.tasks = [task1, task2]
        self.dataModel.save(goal)
        let goalFormDB: Goal? = self.dataModel.fetchObjects()?.first
        expect(goalFormDB).toNot(beNil())
        expect(goalFormDB?.name).to(equal(goal.name))
        expect(goalFormDB?.tasks.count).to(equal(2))

        let tasksFormDB: [Task]? = self.dataModel.fetchObjects()
        expect(tasksFormDB?.count).to(equal(2))
        let task1FormDB = tasksFormDB?.first { $0.objectID == task1.objectID }
        expect(task1FormDB?.name).to(equal(task1.name))
      }

      it("Delete with tasks") {
        let goal = self.generateGoal()
        self.dataModel.save(goal)
        let task1 = self.generateTask()
        let task2 = self.generateTask()
        goal.tasks = [task1, task2]
        self.dataModel.save(goal)
        var goalFormDB: Goal? = self.dataModel.fetchObjects()?.first
        expect(goalFormDB).toNot(beNil())
        expect(goalFormDB?.name).to(equal(goal.name))
        expect(goalFormDB?.tasks.count).to(equal(2))

        var tasksFormDB: [Task]? = self.dataModel.fetchObjects()
        expect(tasksFormDB?.count).to(equal(2))
        let task1FormDB = tasksFormDB?.first { $0.objectID == task1.objectID }
        expect(task1FormDB?.name).to(equal(task1.name))

        self.dataModel.delete(goalFormDB!)
        goalFormDB = self.dataModel.fetchObjects()?.first
        expect(goalFormDB).to(beNil())
        tasksFormDB = self.dataModel.fetchObjects()
        expect(tasksFormDB?.count).to(equal(0))
      }
    }
  }
}
