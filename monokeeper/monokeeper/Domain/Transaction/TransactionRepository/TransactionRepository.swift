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
    
    init(localTransactions: TransactionService = LocaleTransactionService(),
         remoteTransactions: TransactionService = RemoteTransactionService()) {
        self.localTransactions = localTransactions
        self.remoteTransactions = remoteTransactions
    }
    
    func load() async throws -> [RawTransaction] {
        // TODO: WORK WITH LOCAL TRANSACTIONS
        /*
         - get lates transactions data and load new ones
         - OR is empty - force remove load for this month
         */
        
        let remoteTransactions = try await remoteTransactions.fetch()
        return remoteTransactions
    }
}
