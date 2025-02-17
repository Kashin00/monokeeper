//
//  Storage.swift
//  monokeeper
//
//  Created by Matviy Kashin on 17.02.2025.
//

import Foundation
import CoreData

protocol Storage {
  func saveContext()
  
  @discardableResult
  func addEntities<E: ManagedObjectConvertible>(_ entities: [E]) -> [E.ManagedObjectType]
  
  func fetchObjectsOf<T: PersistenceEntityType>(_ type: T.Type, predicate: NSPredicate?) -> [T]
  func fetchObjectsOf<T: PersistenceEntityType>(_ type: T.Type, count: Int, offset: Int) -> [T]
  func fetchAllObjects<T: PersistenceEntityType>(_ type: T.Type) -> [T]
  
  func removeObjects<T: PersistenceEntityType>(_ objects: [T])
}

protocol ManagedObjectConvertible {
    associatedtype ManagedObjectType: PersistenceEntityType
    func copyPropertiesTo(_ object: ManagedObjectType)
    init(dbEntity: ManagedObjectType)
}

protocol PersistenceEntityType: NSManagedObject {
    static var entityName: String { get }
}
