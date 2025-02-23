//
//  ProfileViewModel.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation
import SwiftUI

struct ProfileDependencyContainer {
    let authService: AuthService
    
    init(authService: AuthService = AuthService()) {
        self.authService = authService
    }
}

@Observable
class ProfileViewModel: @unchecked Sendable {
    
    let dependencies: ProfileDependencyContainer
    
    init(dependencies: ProfileDependencyContainer) {
        self.dependencies = dependencies
    }
    
    func onAppear() {
        
    }
    
    func logout() {
        Task {
            await dependencies.authService.logout()
        }
    }
}
