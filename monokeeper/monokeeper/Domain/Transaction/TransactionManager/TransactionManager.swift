//
//  TransactionManager.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

class TransactionManager {
    
    private let transactionRepository: TransactionRepository
    private let transactionEnricher: TransactionEnricher
    private let userService: UserService
    
    init(transactionRepository: TransactionRepository = TransactionRepository(),
         transactionEnricher: TransactionEnricher = TransactionEnricher(),
         userService: UserService) {
        self.transactionRepository = transactionRepository
        self.transactionEnricher = transactionEnricher
        self.userService = userService
    }
    
    func fetch() async throws -> [Transaction] {
        return try await transactionRepository.load()
    }
    
    func enrich(transaction: Transaction, enrich: TransactionEnrich) {
        transactionEnricher.enrich(transaction, enrich: enrich)
    }
}
