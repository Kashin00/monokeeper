//
//  CashFlowViewModel.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation
import SwiftUI

@Observable
class CashFlowViewModel: @unchecked Sendable {
    
    let dependencies: CaseFlowDependencyContainer
    
    init(dependencies: CaseFlowDependencyContainer) {
        self.dependencies = dependencies
    }
    
    var state: State = .loading
    var selectionAccounts: [User.Account] = []
    
    var accountSelectionSheetIsPresented: Bool {
        !selectionAccounts.isEmpty
    }
    
    private(set) var handlingTransaction: Transaction?
    
    var transactionHandlingAvailable = false
    
    func onAppear() async {
        await authORFetch()
    }
    
    func processToken(_ token: String) {
        Task {
            await dependencies.authService.auth(token: token)
            try await dependencies.userService.load()
            await loadTransactions()
        }
    }
    
    func reload() {
        Task {
            await loadTransactions()
        }
    }
    
    private func authORFetch() async {
        switch await dependencies.authService.check() {
        case true:
            await loadTransactions()
        case false:
            proposeAuthFlow()
        }
    }
    
    private func proposeAuthFlow() {
        updateState(.notAvailable)
    }
    
    private func loadTransactions() async {
        do {
            let transactions = try await dependencies.transactionManager.fetch()
            updateState(.available(transactions))
        } catch let error as NetworkError.User {
            switch error {
            case .noAccounts:
                await chooseAccounts()
                
            case .authError:
                proposeAuthFlow()
            }
        } catch {
            updateState(.failed)
        }
    }
    
    private func chooseAccounts() async {
        do {
            let user = try await dependencies.userService.load()
            self.selectionAccounts = user.accounts
        } catch {
            proposeAuthFlow()
        }
    }
    
    func selectAccounts(_ accounts: [User.Account]) {
        dependencies.accountService.saveAccounts(accounts)
        selectionAccounts = []
        reload()
    }
    
    func transactionTap(_ transaction: Transaction) {
        self.handlingTransaction = transaction
        transactionHandlingAvailable = true
    }
    
    func enrich(transaction: Transaction, enrich: TransactionEnrich = .init(category: .init(name: "123"), amount: 123)) {
        self.handlingTransaction = nil
        dependencies.transactionManager.enrich(transaction: transaction, enrich: enrich)
    }
}
