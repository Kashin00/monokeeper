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
                    ForEach(transactions, id: \.id) {
                        Text($0.description)
                    }
                    .frame(maxWidth: .infinity)
                }
                
            case .failed:
                FailedView {
                    vm.reload()
                }
                
            case .notAvailable:
                NotAvailableView {
                    vm.processToken($0)
                }
                .padding(20)
                
            case .loading:
                ProgressView()
            }
        }
        .task {
            await vm.onAppear()
        }
        .sheet(isPresented: .init(get: {
            vm.accountSelectionSheetIsPresented
        }, set: { _ in
            
        })) {
            AccountsSelectionSheet()
        }
    }
}
