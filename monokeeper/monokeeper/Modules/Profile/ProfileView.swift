//
//  ProfileView.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(ProfileViewModel.self) var vm
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                vm.onAppear()
            }
    }
}

#Preview {
    ProfileView()
}
