//
//  TransactionEnricher.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

class TransactionEnricher {
    
    let storage: Storage
    
    init(storage: Storage = StorageService()) {
        self.storage = storage
    }
    
    func enrich(_ transaction: Transaction, enrich: TransactionEnrich) {
         let enrichedTransaction = Transaction(
            transaction: transaction,
            enrich: enrich
         )
        
        storage.addEntities([enrichedTransaction])
        storage.saveContext()
    }
}
