//
//  RemoteTransactionService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

class RemoteTransactionService: TransactionService, @unchecked Sendable {
    
    let networkService: NetworkService
    let keychainService: KeychainService
    
    init(networkService: NetworkService = NetworkService(), keychainService: KeychainService = KeychainService()) {
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    func fetch(accounts: [String], from: Int, to: Int) async throws -> [Transaction] {
        guard let token = keychainService[.token] else {
            throw NetworkError.User.authError
        }
        
        let response: [(String, [TransactionResponse])] = try await withThrowingTaskGroup(of: (String, [TransactionResponse]).self) { group in
            
            accounts.forEach { account in
                group.addTask {
                    let transactions: [TransactionResponse] = try await self.networkService.request(.transactions(.init(token: token,
                                                                         accountNumber: account,
                                                                         from: from,
                                                                         to: to)))
                    
                    return (account, transactions)
                    
                }
            }
            
            return try await group.reduce(into: []) { partialResult, relation in
                partialResult.append(relation)
            }
            
        }
        
        let transactions: [Transaction] = response.flatMap { account, transactions in
            transactions.map { transaction in
                Transaction(
                    id: transaction.id,
                    description: transaction.description,
                    amount: transaction.amount,
                    time: transaction.time,
                    accountId: account
                )
            }
        }
        
        return transactions

    }
}
