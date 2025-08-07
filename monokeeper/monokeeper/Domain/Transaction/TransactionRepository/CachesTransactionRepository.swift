//
//  CachesTransactionRepository.swift
//  monokeeper
//
//  Created by Matviy Kashin on 07.08.2025.
//

import Foundation

class CachesTransactionRepository: TransactionRepository {
    
    let decoratedRepository: TransactionRepository
    let storageService: Storage
    
    init(decoratedRepository: TransactionRepository,
         storageService: Storage = StorageService()) {
        self.decoratedRepository = decoratedRepository
        self.storageService = storageService
    }
    
    func fetch(with request: TransactionsFetchRequest) async throws -> [Transaction] {
        let remoteTransactions = try await decoratedRepository.fetch(with: request)
        
        storageService.addEntities(remoteTransactions)
        storageService.saveContext()
        
        return remoteTransactions
    }
}

