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
    
    var state: State = .notAvailable
    
    func onAppear() async {
        await authORFetch()
    }
    
    func saveToken(_ token: String) {
        Task {
            await dependencies.authService.auth(token: token)
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
