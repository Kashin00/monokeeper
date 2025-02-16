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
        } catch {
            updateState(.failed)
        }
    }
}
