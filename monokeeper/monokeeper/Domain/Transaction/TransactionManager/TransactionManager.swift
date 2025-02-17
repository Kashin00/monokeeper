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
    let userService: UserService
    
    init(transactionRepository: TransactionRepository = TransactionRepository(),
         transactionEnricher: TransactionEnricher = TransactionEnricher(),
         userService: UserService) {
        self.transactionRepository = transactionRepository
        self.transactionEnricher = transactionEnricher
        self.userService = userService
    }
    
    func fetch() async throws -> [EnrichedTransaction] {
        let transactions = try await transactionRepository.load()
        return transactionEnricher.enrich(transactions)
    }
}
