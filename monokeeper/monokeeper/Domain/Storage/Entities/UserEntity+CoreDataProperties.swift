//
//  UserEntity+CoreDataProperties.swift
//  monokeeper
//
//  Created by Matviy Kashin on 17.02.2025.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var clientId: String
    @NSManaged public var name: String
    @NSManaged public var accounts: NSSet

}

// MARK: Generated accessors for accounts
extension UserEntity {

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: AccountEntity)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: AccountEntity)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSSet)

}

extension UserEntity : Identifiable {

}
