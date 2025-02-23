//
//  AccountService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 23.02.2025.
//

import Foundation

class AccountService {
    
    let storageService: StorageService
    
    init(storageService: StorageService = StorageService()) {
        self.storageService = storageService
    }
    
    func getAccounts() -> [User.Account] {
        return storageService
            .fetchAllObjects(AccountEntity.self)
            .compactMap { User.Account(dbEntity: $0) }
    }
    
    func saveAccounts(_ accounts: [User.Account]) {
        storageService.addEntities(accounts)
        storageService.saveContext()
    }
}
