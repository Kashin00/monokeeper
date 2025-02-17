//
//  AccountEntity+CoreDataClass.swift
//  monokeeper
//
//  Created by Matviy Kashin on 17.02.2025.
//
//

import Foundation
import CoreData

@objc(AccountEntity)
public class AccountEntity: NSManagedObject, PersistenceEntityType {
    static var entityName: String {
        return "AccountEntity"
    }
}
