//
//  TabContainerView.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation
import SwiftUI

struct TabContainerView: View {
    
    var body: some View {
        TabView {
            CashFlowView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Cash Flow")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    TabContainerView()
}
