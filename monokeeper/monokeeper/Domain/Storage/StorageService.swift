//
//  StorageService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 17.02.2025.
//

import Foundation
import CoreData

protocol ManagedObjectConvertible {
    associatedtype ManagedObjectType: PersistenceEntityType
    func copyPropertiesTo(_ object: ManagedObjectType)
    init(dbEntity: ManagedObjectType)
}

protocol PersistenceEntityType: NSManagedObject {
    static var entityName: String { get }
}


//class StorageService {
//
//    let persistentContainer: NSPersistentContainer
//
//    init() {
//        persistentContainer = NSPersistentContainer(name: "monokeeperDB")
//        persistentContainer.loadPersistentStores { storeDescription, error in
//            if let error = error {
//                fatalError("Unresolved error \(error)" )
//            }
//        }
//        privateContext.parent = mainContext
//    }
//
//    var mainContext: NSManagedObjectContext { return persistentContainer.viewContext }
//    var privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//
//    var context: NSManagedObjectContext {
//        return privateContext
//   }
//
//    // MARK: - Fetch Data
//    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
//        let entityName = String(describing: objectType)
//        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
//
//        do {
//            let fetchedObjects = try context.fetch(fetchRequest)
//            return fetchedObjects
//        } catch {
//            print("Failed to fetch \(entityName):", error)
//            return []
//        }
//    }
//
//    // MARK: - Insert Data
//    func insert<T: NSManagedObject>(_ objectType: T.Type) -> T? {
//        let entityName = String(describing: objectType)
//        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
//            print("Failed to create entity \(entityName)")
//            return nil
//        }
//        let object = T(entity: entity, insertInto: context)
//        return object
//    }
//
//    // MARK: - Delete Data
//    func delete(_ object: NSManagedObject) {
//        context.delete(object)
//        saveContext()
//    }
//
//    // MARK: - Save Context
//    func saveContext() {
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                print("Failed to save context:", error)
//            }
//        }
//    }
//}

//extension StorageService {
//    func saveTransactions(_ transactions: [RawTransaction]) {
//        let entities = transactions.compactMap {
//            let entity = TransactionEntity(context: context)
//            entity.id = $0.id
//            return entity
//        }
//
////        insert(entities)
//        saveContext()
//    }
//}

import CoreData

final class StorageService {

    private let persistentContainer: NSPersistentContainer
    
    var mainContext: NSManagedObjectContext { return persistentContainer.viewContext }
    var privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    init() {
        persistentContainer = NSPersistentContainer(name: "monokeeperDB")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)" )
            }
        }
        privateContext.parent = mainContext
    }
    
    var context: NSManagedObjectContext {
        privateContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context:", error)
            }
        }
    }
    
    @discardableResult
    func addEntities<E: ManagedObjectConvertible>(_ entities: [E]) -> [E.ManagedObjectType] {
        var objects: [E.ManagedObjectType] = []
        for entity in entities {
            guard
                let description = NSEntityDescription.entity(
                    forEntityName: E.ManagedObjectType.entityName,
                    in: context) else {
                return []
            }
            let object = E.ManagedObjectType(entity: description, insertInto: context)
            entity.copyPropertiesTo(object)
            objects.append(object)
        }
        print("ONJECTS: ", objects.count)
        return objects
    }
    
    func fetchObjectsOf<T>(_ type: T.Type, predicate: NSPredicate?) -> [T] where T: PersistenceEntityType {
        let fetchRequest = NSFetchRequest<T>(entityName: T.entityName)
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        var objects: [T] = []
        do {
            objects = try context.fetch(fetchRequest)
        } catch {
            fatalError()
        }
        return objects
    }
    
    func fetchAllObjects<T>(_ type: T.Type) -> [T] where T : PersistenceEntityType {
        let fetchRequest = NSFetchRequest<T>(entityName: T.entityName)
        var objects: [T] = []
        do {
            objects = try self.context.fetch(fetchRequest)
        } catch {
            fatalError()
        }
        return objects
    }
    
    func fetchObjectsOf<T>(_ type: T.Type, count: Int = 0, offset: Int = 0) -> [T] where T: PersistenceEntityType {
        let fetchRequest = NSFetchRequest<T>(entityName: T.entityName)
        
        if count >= 0 {
            fetchRequest.fetchLimit = count
        }
        
        fetchRequest.fetchOffset = offset
        var objects: [T] = []
        do {
            objects = try context.fetch(fetchRequest)
        } catch {
            fatalError()
        }
        return objects
    }
    
    func removeObjects<T>(_ objects: [T]) where T: PersistenceEntityType {
        objects.forEach { (entity) in
            context.delete(entity)
        }
    }
}
