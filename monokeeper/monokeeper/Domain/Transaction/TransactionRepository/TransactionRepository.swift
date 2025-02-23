//
//  TransactionRepository.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

class TransactionRepository {
    
    let localTransactions: TransactionService
    let remoteTransactions: TransactionService
    let storageService: Storage
    
    init(localTransactions: TransactionService = LocaleTransactionService(),
         remoteTransactions: TransactionService = RemoteTransactionService(),
         storageService: Storage = StorageService()) {
        self.localTransactions = localTransactions
        self.remoteTransactions = remoteTransactions
        self.storageService = storageService
    }
    
    func load() async throws -> [Transaction] {
        
        let accounts: [String] = storageService.fetchAllObjects(AccountEntity.self).compactMap(\.id)
        
        guard !accounts.isEmpty else { throw NetworkError.Data.noAccounts }
        
        let savedTransactions = try await localTransactions.fetch(accounts: accounts, from: 0, to: 0)
        
        let start = savedTransactions.sorted(by: { $0.time < $1.time }).last?.time ?? Int(Date().startOfMonth().timeIntervalSince1970)
        let finish = Int(Date().endOfMonth().timeIntervalSince1970)
        
        let remoteTransactions = try await remoteTransactions.fetch(accounts: accounts,
                                                                    from: start,
                                                                    to: finish)
        
        storageService.addEntities(remoteTransactions)
        storageService.saveContext()
        
        return savedTransactions + remoteTransactions
    }
}
