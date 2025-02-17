//
//  UserEntity+CoreDataClass.swift
//  monokeeper
//
//  Created by Matviy Kashin on 17.02.2025.
//
//

import Foundation
import CoreData

@objc(UserEntity)
public class UserEntity: NSManagedObject, PersistenceEntityType {
    static var entityName: String {
        return "UserEntity"
    }
}
