//
//  TransactionEntity+CoreDataProperties.swift
//  monokeeper
//
//  Created by Matviy Kashin on 23.02.2025.
//
//

import Foundation
import CoreData


extension TransactionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        return NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }

    @NSManaged public var accountId: String
    @NSManaged public var amount: Int64
    @NSManaged public var desc: String
    @NSManaged public var id: String
    @NSManaged public var time: Int64
    @NSManaged public var category: TransactionCategoryEntity?

}

extension TransactionEntity : Identifiable {

}
