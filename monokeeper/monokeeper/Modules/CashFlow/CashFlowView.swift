//
//  CashFlowView.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation
import SwiftUI

struct CashFlowView: View {
    
    @Environment(CashFlowViewModel.self) var vm
    
    var body: some View {
        VStack {
            switch vm.state {
            case .available(let transactions):
                ScrollView {
                    ForEach(transactions, id: \.transaction.id) {
                        Text($0.transaction.description)
                    }
                }
            case .failed:
                Text("Failed to load data")
                
            case .notAvailable:
                Text("Not available. Please make authorization")
            }
        }
        .task {
            await vm.onAppear()
        }
    }
}
