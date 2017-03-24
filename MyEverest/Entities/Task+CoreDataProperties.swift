//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Yerkebulan Abildin on 13.08.17.
//
//

import Foundation
import CoreData

extension Task {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged var name: String?
    @NSManaged var note: String?
    @NSManaged var doneDate: Date?
    @NSManaged var dueDate: Date?
    @NSManaged var isComplete: Bool
    @NSManaged var id: Int
    @NSManaged var goal: Goal?

}
