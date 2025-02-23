//
//  ContentView.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import SwiftUI

struct ContentView: View {
    
    let userService: UserService
    
    @State private var cashFlowVM: CashFlowViewModel
    @State private var profileVM: ProfileViewModel
    
    init() {
        userService = UserService()
        cashFlowVM = CashFlowViewModel(dependencies: CaseFlowDependencyContainer(transactionManager: TransactionManager(userService: userService), userService: userService))
        profileVM = ProfileViewModel(dependencies: ProfileDependencyContainer(authService: AuthService()))
    }
        
    var body: some View {
        TabContainerView()
            .environment(cashFlowVM)
            .environment(profileVM)
    }
}

#Preview {
    ContentView()
}
