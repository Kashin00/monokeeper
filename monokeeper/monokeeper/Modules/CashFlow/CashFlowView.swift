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
            
        }
        .onAppear {
            vm.onAppear()
        }
    }
}
