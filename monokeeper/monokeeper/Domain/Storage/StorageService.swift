//
//  StorageService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 17.02.2025.
//

import Foundation
import CoreData

final class StorageService: Storage {

    private let persistentContainer: NSPersistentContainer
    
    var privateContext: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "monokeeperDB")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)" )
            }
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        privateContext = persistentContainer.newBackgroundContext()
        privateContext.automaticallyMergesChangesFromParent = true
        privateContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
    }
    
    var context: NSManagedObjectContext {
        privateContext
    }
    
    func saveContext() {
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    fatalError()
                }
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
        print("OBJECTS: ", objects.count)
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
