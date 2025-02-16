//
//  CaseFlowDependencyContainer.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

struct CaseFlowDependencyContainer {
    let authService: AuthService
    let transactionManager: TransactionManager
    
    init(authService: AuthService = AuthService(), transactionManager: TransactionManager = TransactionManager()) {
        self.authService = authService
        self.transactionManager = transactionManager
    }
}
