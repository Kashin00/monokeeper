//
//  FailedView.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation
import SwiftUI

extension CashFlowView {
    struct FailedView: View {
        
        var handler: () -> ()
        
        var body: some View {
            VStack(alignment: .center, spacing: 8) {
                Text("Failed to load data")
                
                Button {
                    handler()
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(Color.blue)
                        .overlay {
                            Text("RELOAD")
                                .foregroundStyle(.white)
                        }
                        .frame(width: 80, height: 30)
                }
            }
        }
    }
}
