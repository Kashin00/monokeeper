//
//  TransactionManager.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

class TransactionManager {
    
    let transactionRepository: TransactionRepository
    let transactionEnricher: TransactionEnricher
    
    init(transactionRepository: TransactionRepository = TransactionRepository(),
         transactionEnricher: TransactionEnricher = TransactionEnricher()) {
        self.transactionRepository = transactionRepository
        self.transactionEnricher = transactionEnricher
    }
    
    func fetch() async throws -> [EnrichedTransaction] {
        let transactions = try await transactionRepository.load()
        return transactionEnricher.enrich(transactions)
    }
}
