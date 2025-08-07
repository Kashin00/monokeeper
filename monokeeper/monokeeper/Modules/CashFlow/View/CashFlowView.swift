//
//  CashFlowView.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation
import SwiftUI

struct CashFlowView: View {
    
    @Binding var vm: CashFlowViewModel
    
    var body: some View {
        VStack {
            switch vm.state {
            case .available(let transactions):
                ScrollView {
                    ForEach(transactions, id: \.id) { transaction in
                        Text(transaction.description)
                            .foregroundStyle(transaction.isHandled ? .red : .black)
                            .onTapGesture {
                                vm.transactionTap(transaction)
                            }
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
            AccountsSelectionSheet(vm: $vm)
        }
        .sheet(isPresented: $vm.transactionHandlingAvailable) {
            if let transaction = vm.handlingTransaction {
                TransactionHandlingView(vm: .init(transaction: transaction))
            }
        }
    }
}
