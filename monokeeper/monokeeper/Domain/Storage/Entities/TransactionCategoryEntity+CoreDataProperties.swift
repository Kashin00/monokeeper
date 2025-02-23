//
//  TransactionCategoryEntity+CoreDataProperties.swift
//  monokeeper
//
//  Created by Matviy Kashin on 23.02.2025.
//
//

import Foundation
import CoreData


extension TransactionCategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionCategoryEntity> {
        return NSFetchRequest<TransactionCategoryEntity>(entityName: "TransactionCategoryEntity")
    }

    @NSManaged public var name: String
}

extension TransactionCategoryEntity : Identifiable {

}
