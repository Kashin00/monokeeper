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
    
    func fetch(accounts: [String], from: Int, to: Int) async throws -> [RawTransaction] {
        guard let token = keychainService[.token] else {
            throw NetworkError.authError
        }
        
        let response: [TransactionResponse] = try await withThrowingTaskGroup(of: [TransactionResponse].self) { group in
            
            accounts.forEach { account in
                group.addTask {
                    try await self.networkService.request(.transactions(.init(token: token,
                                                                         accountNumber: account,
                                                                         from: from,
                                                                         to: to)))
                }
            }
            
            return try await group
                .reduce(into: []) { partialResult, relation in
                    partialResult.append(contentsOf: relation)
                }
            
            
        }
        
        return response.compactMap {
            RawTransaction(id: $0.id, description: $0.description, amount: $0.amount)
        }
    }
}
