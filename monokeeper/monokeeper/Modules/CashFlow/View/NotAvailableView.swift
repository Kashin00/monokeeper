//
//  NotAvailableView.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation
import SwiftUI

extension CashFlowView {
    struct NotAvailableView: View {
        
        @State private var tokenText: String = ""
        var onSubmit: ((String) -> ())
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("To manipulate transactions you need to be authorized.")
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(" 1. Open [this link](https://api.monobank.ua/) and generate a token.")
                    Text(" 2. Paste generated token to field bellow.")
                }
                
                TextField("Generated key", text: $tokenText)
                    .onSubmit {
                        onSubmit(tokenText)
                    }
            }
        }
    }
}
