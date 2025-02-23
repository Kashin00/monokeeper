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
        Button {
            vm.logout()
        } label: {
            Text("Log out")
        }
    }
}

#Preview {
    ProfileView()
}
