//
//  TransactionHandlingView.swift
//  monokeeper
//
//  Created by Matviy Kashin on 01.03.2025.
//

import SwiftUI

@Observable
class TransactionHandlingViewModel: @unchecked Sendable {
    
    private(set) var transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    func selectCategory(_ category: String) {
        self.transaction = .init(transaction: transaction, enrich: .init(category: .init(name: category), amount: transaction.amount))
    }
}

struct TransactionHandlingView: View {
    
    @State var vm: TransactionHandlingViewModel
    
    var body: some View {
        VStack {
            Text("\(vm.transaction.description)")
            Text("\(vm.transaction.amount)")
            Text("\(Date(timeIntervalSince1970: .init(vm.transaction.amount)))")
            
            Menu {
                ForEach(["1", "2", "3"], id: \.self) { item in
                    Button {
                        vm.selectCategory(item)
                    } label: {
                        Text(item)
                    }
                }
                
                Text("123")
            } label: {
                if let selectedCategory = vm.transaction.category {
                    Text("Selected category: \(selectedCategory.name)")
                } else {
                    Text("Select category")
                }
            }
        }
    }
}

struct TransactionCategorySelectionView: View {
    
    let categories: [TransactionCategory]
    
    var body: some View {
        ForEach(categories, id: \.name) {
            Text($0.name)
        }
        .presentationDetents([.medium, .large])
    }
    
}
