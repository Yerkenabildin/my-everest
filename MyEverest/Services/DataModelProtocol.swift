//
//  DataModelProtocol.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 03.09.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

protocol DataModelProtocol {
  typealias ObjectsParentClass = NSManagedObject
  func fetchObjects<T: ObjectsParentClass>() -> [T]?
  func fetch<T: ObjectsParentClass>(object: T) -> T?
  func delete<T: ObjectsParentClass>(allObjectOf type: T.Type)
  func insert<T: ObjectsParentClass>(_ object: T)
  func save<T: ObjectsParentClass>(_ object: T)
  func update<T: ObjectsParentClass>(_ object: T)
  func delete<T: ObjectsParentClass>(_ object: T)

  func rxFetchObjects<T: ObjectsParentClass>(predicate: NSPredicate?) -> Observable<[T]>
  func rxFetch<T: ObjectsParentClass>(objectWith predicate: NSPredicate) -> Observable<T?>
  func rxFetch<T: ObjectsParentClass>(object: T) -> Observable<T?>
}
