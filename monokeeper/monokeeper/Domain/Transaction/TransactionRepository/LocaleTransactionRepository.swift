//
//  LocaleTransactionService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

class LocalTransactionRepository: TransactionRepository {

    let decoratedRepository: TransactionRepository
    let storage: StorageService
    
    init(decoratedRepository: TransactionRepository, storage: StorageService = StorageService()) {
        self.decoratedRepository = decoratedRepository
        self.storage = storage
    }
    
    func fetch(with request: TransactionsFetchRequest) async throws -> [Transaction] {
        let localData = self.localData(with: request)
        
        var start: Int {
            guard let startTime = localData.sorted(by: { $0.time < $1.time }).last?.time else {
                return Int(Date().startOfMonth().timeIntervalSince1970)
            }
            
            return startTime + 1
        }
        
        let finish = Int(Date().endOfMonth().timeIntervalSince1970)
        
        let remoteData = try await self.decoratedRepository.fetch(with: .init(accounts: request.accounts, from: start, to: finish))
        
        return localData.sorted(by: { $0.time > $1.time }) + remoteData.sorted(by: { $0.time > $1.time })
    }
    
    private func localData(with request: TransactionsFetchRequest) -> [Transaction] {
        let predicates = request.accounts.compactMap { NSPredicate(format: "accountId = %@", $0) }

        let compound = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        
        return storage.fetchObjectsOf(TransactionEntity.self, predicate: compound).compactMap {
            Transaction(dbEntity: $0)
        }
    }
}
