//
//  UserService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

actor UserService {
    
    let networkService = NetworkService()
    let keychainService = KeychainService()
    
    private var user: User?
    
    func current() async throws -> User {
        if let user {
            return user
        } else {
            return try await load()
        }
    }
    
    @discardableResult
    func load() async throws -> User {
        guard let token = keychainService[.token] else {
            throw NetworkError.User.authError
        }
        
        let response: User = try await networkService.request(.userInfo(.init(token: token)))
        self.user = response
        
        return response
    }
}
