//
//  ContentView.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var cashFlowVM = CashFlowViewModel(dependencies: CaseFlowDependencyContainer())
    @State private var profileVM = ProfileViewModel()
        
    var body: some View {
        TabContainerView()
            .environment(cashFlowVM)
            .environment(profileVM)
    }
}

#Preview {
    ContentView()
}
