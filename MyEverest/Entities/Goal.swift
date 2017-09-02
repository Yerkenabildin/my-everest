//
//  Goal+CoreDataClass.swift
//  
//
//  Created by Yerkebulan Abildin on 13.08.17.
//
//

import Foundation
import CoreData

@objc(Goal)
class Goal: NSManagedObject {

  @NSManaged var name: String?
  @NSManaged var note: String?
  @NSManaged var colorIndex: Int
  @NSManaged var tasksSet: Set<Task>?
  @NSManaged var doneDate: Date?
  @NSManaged var dueDate: Date?
  @NSManaged var isComplete: Bool

  var color: MaterialColor? {
    get {
      return MaterialColor(rawValue: Int(self.colorIndex))
    }
    set {
      guard let rawValue = newValue?.rawValue else {
        return
      }
      self.colorIndex = rawValue
    }
  }

  var tasks: [Task] {
    get {
      return Array(self.tasksSet ?? Set())
    }
    set {
      insertToContext(newValue)
      self.tasksSet = Set(newValue)
    }
  }

  private func insertToContext(_ tasks: [Task]) {
    guard self.managedObjectContext != nil else {
      return
    }
    for task in tasks where task.managedObjectContext == nil {
      CoreDataModel.default.insert(task)
    }
  }

  convenience init() {
    let name = String(describing: type(of: self))
    let entity = CoreDataModel.default.entityForName(name)
    self.init(entity: entity, insertInto: nil)
  }

  override func prepareForDeletion() {
    super.prepareForDeletion()
    for task in self.tasks {
      CoreDataModel.default.delete(task)
    }
  }
}
