//
//  TransactionEntity+CoreDataClass.swift
//  monokeeper
//
//  Created by Matviy Kashin on 23.02.2025.
//
//

import Foundation
import CoreData

@objc(TransactionEntity)
public class TransactionEntity: NSManagedObject, PersistenceEntityType {
    static var entityName: String {
        return "TransactionEntity"
    }
}
