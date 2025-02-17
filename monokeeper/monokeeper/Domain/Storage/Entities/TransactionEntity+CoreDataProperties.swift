//
//  TransactionEntity+CoreDataProperties.swift
//  monokeeper
//
//  Created by Matviy Kashin on 17.02.2025.
//
//

import Foundation
import CoreData


extension TransactionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        return NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var desc: String
    @NSManaged public var amount: Int
    @NSManaged public var time: Int
    @NSManaged public var accountId: String

}

extension TransactionEntity : Identifiable {

}
