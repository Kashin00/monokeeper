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
    private let accountService: AccountService
    
    init(transactionRepository: TransactionRepository = LocalTransactionRepository(decoratedRepository: CachesTransactionRepository(decoratedRepository: RemoteTransactionRepository())),
         transactionEnricher: TransactionEnricher = TransactionEnricher(),
         accountService: AccountService = AccountService()) {
        self.transactionRepository = transactionRepository
        self.transactionEnricher = transactionEnricher
        self.accountService = accountService
    }
    
    func fetch() async throws -> [Transaction] {
        let accounts: [String] = accountService.getAccounts().compactMap(\.id)
        
        guard !accounts.isEmpty else { throw NetworkError.User.noAccounts }
        
        return try await transactionRepository.fetch(with: .init(accounts: accounts,
                                                                 from: Int(Date().startOfMonth().timeIntervalSince1970),
                                                                 to: Int(Date().endOfMonth().timeIntervalSince1970)))
    }
    
    func enrich(transaction: Transaction, enrich: TransactionEnrich) {
        transactionEnricher.enrich(transaction, enrich: enrich)
    }
}
