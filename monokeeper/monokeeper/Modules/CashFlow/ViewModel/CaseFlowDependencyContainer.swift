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
    let userService: UserService
    
    init(authService: AuthService = AuthService(), transactionManager: TransactionManager, userService: UserService) {
        self.authService = authService
        self.transactionManager = transactionManager
        self.userService = userService
    }
}
