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
      self.tasksSet = Set(newValue)
    }
  }

  convenience init() {
    let name = String(describing: type(of: self))
    guard let entity = CoreDataModel.shared.entityForName(name) else {
      fatalError(MyError.nilValue)
    }
    self.init(entity: entity, insertInto: CoreDataModel.shared.managedObjectContext)
  }

  override func prepareForDeletion() {
    for task in self.tasks {
      CoreDataModel.shared.delete(task)
    }
  }
}
