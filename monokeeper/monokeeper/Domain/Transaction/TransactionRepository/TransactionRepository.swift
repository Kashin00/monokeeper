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
    
    func load(for user: User) async throws -> [RawTransaction] {
        // TODO: WORK WITH LOCAL TRANSACTIONS
        /*
         - get lates transactions data and load new ones
         - OR is empty - force remove load for this month
         */
        
        let remoteTransactions = try await remoteTransactions.fetch(accounts: user.accounts.compactMap(\.id),
                                                                    from: Int(Date.now.addingTimeInterval(-90000).timeIntervalSince1970),
                                                                    to: Int(Date.now.timeIntervalSince1970))
        return remoteTransactions
    }
}
