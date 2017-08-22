//
//  CoreDataModel.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 13.08.17.
//
//

import Foundation
import CoreData
import RxSwift
import RxCoreData

fileprivate struct Constant {
  static let storageName = "MyEverest"
  static let testStorageName = "MyEverestTest"
}

class CoreDataModel: ReactiveCompatible {

  static let shared = CoreDataModel()
  var databaseName = "\(Constant.storageName).sqlite"

  private init() {
    if ProcessInfoManager.isDatabaseEmpty {
      self.databaseName = "\(Constant.testStorageName).sqlite"
    }
  }

  // MARK: - Fetch
  func fetchObjects<T: NSManagedObject>() -> [T]? {
    let entityName = String(describing: T.self)
    let fetchRequest = NSFetchRequest<T>(entityName: entityName)
    var results: [T]?
    do {
      results = try self.managedObjectContext.fetch(fetchRequest)
    } catch let error {
      unexpectedError(error.localizedDescription)
    }
    return results
  }

  func fetchObject<T: NSManagedObject>(by objectID: NSManagedObjectID) -> T? {
    return self.managedObjectContext.object(with: objectID) as? T
  }

  // MARK: - Delete
  func delete<T: NSManagedObject>(_ object: T) {
    self.managedObjectContext.delete(object)
    self.saveContext()
  }

  func deleteAllObjects<T: NSManagedObject>(of type: T.Type) {
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)

    do {
      try self.managedObjectContext.execute(deleteRequest)
    } catch {
      unexpectedError(error.localizedDescription)
    }
  }

  // MARK: - Entity for Name
  func entityForName(_ entityName: String) -> NSEntityDescription? {
    guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext) else {
      unexpectedError(MyError.nilValue)
      return nil
    }
    return entity
  }

  // MARK: - Core Data Saving support
  func saveContext() {
    guard managedObjectContext.hasChanges else {
      return
    }
    do {
      try managedObjectContext.save()
    } catch {
      unexpectedError(error.localizedDescription)
      abort()
    }
  }

  lazy var managedObjectContext: NSManagedObjectContext = {
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
    return managedObjectContext
  }()

  private lazy var applicationDocumentsDirectory: NSURL = {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.count-1] as NSURL
  }()

  private lazy var managedObjectModel: NSManagedObjectModel = {
    guard let modelURL = Bundle.main.url(forResource: Constant.storageName, withExtension: "momd"),
      let object = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError(MyError.nilValue)
    }
    return object
  }()

  private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentsDirectory.appendingPathComponent(self.databaseName)
    var failureReason = MyError.localStorageFail.localizedDescription
    do {
      try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
    } catch {
      var dict = [String: AnyObject]()
      dict[NSLocalizedDescriptionKey] = failureReason as AnyObject
      dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
      dict[NSUnderlyingErrorKey] = error as NSError
      let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
      abort()
    }
    return coordinator
  }()
}

extension Reactive where Base: CoreDataModel {
  func fetchObjects<T: NSManagedObject>(predicate: NSPredicate? = nil) -> Observable<[T]> {
    let entityName = String(describing: T.self)
    let fetchRequest = NSFetchRequest<T>(entityName: entityName)
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    fetchRequest.predicate = predicate
    return base.managedObjectContext.rx.entities(fetchRequest: fetchRequest)
  }

  func fetchObject<T: NSManagedObject>(predicate: NSPredicate? = nil) -> Observable<T?> {
    let entityName = String(describing: T.self)
    let fetchRequest = NSFetchRequest<T>(entityName: entityName)
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    fetchRequest.predicate = predicate
    return base.managedObjectContext.rx.entities(fetchRequest: fetchRequest).map { $0.first }
  }
}
