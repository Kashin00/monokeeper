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
    let accountService: AccountService
    
    init(localTransactions: TransactionService = LocaleTransactionService(),
         remoteTransactions: TransactionService = RemoteTransactionService(),
         storageService: Storage = StorageService(),
         accountService: AccountService = AccountService()) {
        self.localTransactions = localTransactions
        self.remoteTransactions = remoteTransactions
        self.storageService = storageService
        self.accountService = accountService
    }
    
    func load() async throws -> [Transaction] {
        
        let accounts: [String] = accountService.getAccounts().compactMap(\.id)
        
        guard !accounts.isEmpty else { throw NetworkError.User.noAccounts }
        
        let savedTransactions = try await localTransactions.fetch(accounts: accounts, from: 0, to: 0)
        
        var start: Int {
            guard let startTime = savedTransactions.sorted(by: { $0.time < $1.time }).last?.time else {
                return Int(Date().startOfMonth().timeIntervalSince1970)
            }
            
            return startTime + 1
        }
        
        let finish = Int(Date().endOfMonth().timeIntervalSince1970)
        
        let remoteTransactions = try await remoteTransactions.fetch(accounts: accounts,
                                                                    from: start,
                                                                    to: finish)
        
        storageService.addEntities(remoteTransactions)
        storageService.saveContext()
        
        return savedTransactions.sorted(by: { $0.time > $1.time }) + remoteTransactions.sorted(by: { $0.time > $1.time })
    }
}
