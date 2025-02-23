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
    let category: TransactionCategory?
    
    var isHandled: Bool {
        category != nil
    }
    
    init(id: String, description: String, amount: Int, time: Int, accountId: String, category: TransactionCategory?) {
        self.id = id
        self.description = description
        self.amount = amount
        self.time = time
        self.accountId = accountId
        self.category = category
    }
    
    init(transaction: Self, enrich: TransactionEnrich) {
        self.id = transaction.id
        self.description = transaction.description
        self.amount = enrich.amount
        self.time = transaction.time
        self.accountId = transaction.accountId
        self.category = enrich.category
    }
    
    init(dbEntity: TransactionEntity) {
        self.id = dbEntity.id
        self.description = dbEntity.desc
        self.amount = Int(dbEntity.amount)
        self.time = Int(dbEntity.time)
        self.accountId = dbEntity.accountId
        
        if let category = dbEntity.category {
            self.category = .init(dbEntity: category)
        } else {
            self.category = nil
        }
    }
    
    func copyPropertiesTo(_ object: TransactionEntity) {
        object.id = self.id
        object.desc = self.description
        object.amount = Int64(self.amount)
        object.time = Int64(self.time)
        object.accountId = self.accountId
        
        guard let context = object.managedObjectContext else {
            object.category = nil
            return
        }
        let categoryEntity = TransactionCategoryEntity(context: context)
        self.category?.copyPropertiesTo(categoryEntity)
        object.category = categoryEntity
    }
}
