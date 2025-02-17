//
//  AccountEntity+CoreDataProperties.swift
//  monokeeper
//
//  Created by Matviy Kashin on 17.02.2025.
//
//

import Foundation
import CoreData


extension AccountEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountEntity> {
        return NSFetchRequest<AccountEntity>(entityName: "AccountEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var sendId: String
    @NSManaged public var maskedPan: [String]

}

extension AccountEntity : Identifiable {

}
