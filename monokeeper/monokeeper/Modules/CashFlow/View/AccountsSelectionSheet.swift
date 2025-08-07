//
//  AccountsSelectionSheet.swift
//  monokeeper
//
//  Created by Matviy Kashin on 23.02.2025.
//

import SwiftUI

struct AccountsSelectionSheet: View {
    
    @Binding var vm: CashFlowViewModel
    
    @State private var selection: Set<String> = []
    
    var body: some View {
        VStack {
            List(vm.selectionAccounts, selection: $selection) {
                Text($0.maskedPan.first ?? "")
            }

            Button {
                vm.selectAccounts(vm.selectionAccounts.filter({ selection.contains($0.id) }))
            } label: {
                Text("Select")
            }
        }
        .environment(\.editMode, .constant(EditMode.active))
        .interactiveDismissDisabled()
    }
}
