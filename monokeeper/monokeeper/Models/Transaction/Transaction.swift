//
//  Transaction.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

struct Transaction: ManagedObjectConvertible {
    
    let id: String
    let description: String
    let amount: Int
    let time: Int
    let accountId: String
    let category: String?
    
    var isHandled: Bool {
        category != nil
    }
    
    init(id: String, description: String, amount: Int, time: Int, accountId: String, category: String?) {
        self.id = id
        self.description = description
        self.amount = amount
        self.time = time
        self.accountId = accountId
        self.category = category
    }
    
    init(dbEntity: TransactionEntity) {
        self.id = dbEntity.id
        self.description = dbEntity.desc
        self.amount = dbEntity.amount
        self.time = dbEntity.time
        self.accountId = dbEntity.accountId
        self.category = dbEntity.category
    }
    
    func copyPropertiesTo(_ object: TransactionEntity) {
        object.id = self.id
        object.desc = self.description
        object.amount = self.amount
        object.time = self.time
        object.accountId = self.accountId
        object.category = self.category
    }
}
