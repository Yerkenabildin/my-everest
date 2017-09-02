//
//  Task+CoreDataClass.swift
//  
//
//  Created by Yerkebulan Abildin on 13.08.17.
//
//

import Foundation
import CoreData

@objc(Task)
class Task: NSManagedObject {

  @NSManaged var name: String?
  @NSManaged var note: String?
  @NSManaged var doneDate: Date?
  @NSManaged var dueDate: Date?
  @NSManaged var isComplete: Bool
  @NSManaged var goal: Goal?

  convenience init() {
    let name = String(describing: type(of: self))
    let entity = CoreDataModel.default.entityForName(name)
    self.init(entity: entity, insertInto: nil)
  }
}
