//
//  TabContainerView.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation
import SwiftUI

struct TabContainerView: View {
    
    let userService: UserService
    
    @State private var cashFlowVM: CashFlowViewModel
    @State private var profileVM: ProfileViewModel
    
    init() {
        userService = UserService()
        cashFlowVM = CashFlowViewModel(dependencies: CaseFlowDependencyContainer(transactionManager: TransactionManager(),
                                                                                 userService: userService))
        profileVM = ProfileViewModel(dependencies: ProfileDependencyContainer(authService: AuthService()))
    }
    
    var body: some View {
        TabView {
            CashFlowView(vm: $cashFlowVM)
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Cash Flow")
                }
            
            ProfileView(vm: $profileVM)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    //    TabContainerView()
}
