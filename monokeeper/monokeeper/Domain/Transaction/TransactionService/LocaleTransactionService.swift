//
//  LocaleTransactionService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

class LocaleTransactionService: TransactionService {
    
    let storage: StorageService
    
    init(storage: StorageService = StorageService()) {
        self.storage = storage
    }
    
    func fetch(accounts: [String], from: Int, to: Int) async throws -> [Transaction] {
        let predicates = accounts.compactMap { NSPredicate(format: "accountId = %@", $0) }

        let compound = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        
        return storage.fetchObjectsOf(TransactionEntity.self, predicate: compound).compactMap {
            Transaction(dbEntity: $0)
        }
    }
}
