//
//  Goal+CoreDataProperties.swift
//  
//
//  Created by Yerkebulan Abildin on 13.08.17.
//
//

import Foundation
import CoreData

extension Goal {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged var id: Int
    @NSManaged var name: String?
    @NSManaged var note: String?
    @NSManaged var colorIndex: Int
    @NSManaged var tasksSet: Set<Task>?

}

// MARK: Generated accessors for tasks
extension Goal {

    @objc(insertObject:inTasksAtIndex:)
    @NSManaged func insertIntoTasks(_ value: Task, at idx: Int)

    @objc(removeObjectFromTasksAtIndex:)
    @NSManaged func removeFromTasks(at idx: Int)

    @objc(insertTasks:atIndexes:)
    @NSManaged func insertIntoTasks(_ values: [Task], at indexes: NSIndexSet)

    @objc(removeTasksAtIndexes:)
    @NSManaged func removeFromTasks(at indexes: NSIndexSet)

    @objc(replaceObjectInTasksAtIndex:withObject:)
    @NSManaged func replaceTasks(at idx: Int, with value: Task)

    @objc(replaceTasksAtIndexes:withTasks:)
    @NSManaged func replaceTasks(at indexes: NSIndexSet, with values: [Task])

    @objc(addTasksObject:)
    @NSManaged func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged func addToTasks(_ values: Set<Task>)

    @objc(removeTasks:)
    @NSManaged func removeFromTasks(_ values: Set<Task>)

}
