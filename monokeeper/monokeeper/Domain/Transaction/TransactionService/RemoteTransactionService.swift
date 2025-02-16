//
//  RemoteTransactionService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

class RemoteTransactionService: TransactionService {
    
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetch() async throws -> [RawTransaction] {
        []
    }
}
