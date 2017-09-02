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

final class CoreDataModel: DataModelProtocol, ReactiveCompatible {

  private var databaseName = "\(Constant.storageName).sqlite"
  static let `default` = CoreDataModel()

  private init() {
    if ProcessInfoManager.isDatabaseEmpty {
      self.databaseName = "\(Constant.testStorageName).sqlite"
    }
  }

  // MARK: - DataModelProtocol
  func fetchObjects<T: NSManagedObject>() -> [T]? {
    let entityName = String(describing: T.self)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    var results: [T]?
    do {
      results = try self.managedObjectContext.fetch(fetchRequest) as? [T]
    } catch {
      unexpectedError(error.localizedDescription)
    }
    return results
  }

  func fetch<T: NSManagedObject>(object: T) -> T? {
    return self.managedObjectContext.object(with: object.objectID) as? T
  }

  func delete<T: NSManagedObject>(_ object: T) {
    guard object.managedObjectContext != nil else {
      return
    }
    self.managedObjectContext.delete(object)
//    self.saveContext()
  }

  func delete<T: NSManagedObject>(allObjectOf type: T.Type) {
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)

    do {
      try self.managedObjectContext.execute(deleteRequest)
    } catch {
      unexpectedError(error.localizedDescription)
    }
    self.saveContext()
  }

  func insert<T: NSManagedObject>(_ object: T) {
    self.managedObjectContext.insert(object)
  }

  func update<T: NSManagedObject>(_ object: T) {
    self.save(object)
  }

  func save<T: NSManagedObject>(_ object: T) {
    if object.managedObjectContext == nil {
      self.managedObjectContext.insert(object)
    }
    self.saveContext()
  }

  // MARK: - Entity for Name
  func entityForName(_ entityName: String) -> NSEntityDescription {
    guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext) else {
      fatalError(MyError.nilValue)
    }
    return entity
  }

  // MARK: - Save
  private func saveContext() {
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

  // MARK: - Context and Storage
  fileprivate lazy var managedObjectContext: NSManagedObjectContext = {
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

  func rxFetchObjects<T: NSManagedObject>(predicate: NSPredicate?) -> Observable<[T]> {
    let entityName = String(describing: T.self)
    let fetchRequest = NSFetchRequest<T>(entityName: entityName)
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    fetchRequest.predicate = predicate
    return self.managedObjectContext.rx.entities(fetchRequest: fetchRequest)
  }

  func rxFetch<T: NSManagedObject>(object: T) -> Observable<T?> {
    let predicate = NSPredicate(format: "(SELF = %@)", object.objectID)
    return self.rxFetch(objectWith: predicate)
  }

  func rxFetch<T: NSManagedObject>(objectWith predicate: NSPredicate) -> Observable<T?> {
    let entityName = String(describing: T.self)
    let fetchRequest = NSFetchRequest<T>(entityName: entityName)
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    fetchRequest.predicate = predicate
    return self.managedObjectContext.rx.entities(fetchRequest: fetchRequest).map { $0.first }
  }
}
