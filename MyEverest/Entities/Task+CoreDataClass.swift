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

  convenience init() {
    let name = String(describing: type(of: self))
    guard let entity = CoreDataModel.shared.entityForName(name) else {
      fatalError(MyError.nilValue)
    }
    self.init(entity: entity, insertInto: CoreDataModel.shared.managedObjectContext)
  }
}
