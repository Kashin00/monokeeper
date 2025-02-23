//
//  TransactionCategory.swift
//  monokeeper
//
//  Created by Matviy Kashin on 23.02.2025.
//

import Foundation

struct TransactionCategory: ManagedObjectConvertible {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(dbEntity: TransactionCategoryEntity) {
        self.name = dbEntity.name
    }
    
    func copyPropertiesTo(_ object: TransactionCategoryEntity) {
        object.name = self.name
    }
}
