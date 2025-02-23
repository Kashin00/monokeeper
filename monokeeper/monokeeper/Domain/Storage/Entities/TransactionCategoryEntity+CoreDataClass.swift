//
//  TransactionCategoryEntity+CoreDataClass.swift
//  monokeeper
//
//  Created by Matviy Kashin on 23.02.2025.
//
//

import Foundation
import CoreData

@objc(TransactionCategoryEntity)
public class TransactionCategoryEntity: NSManagedObject, PersistenceEntityType {
    static var entityName: String {
        return "TransactionCategoryEntity"
    }
}
