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
    let accountService: AccountService
    
    init(
        authService: AuthService = AuthService(),
        transactionManager: TransactionManager,
        userService: UserService,
        accountService: AccountService = AccountService()
    ) {
        self.authService = authService
        self.transactionManager = transactionManager
        self.userService = userService
        self.accountService = accountService
    }
}
