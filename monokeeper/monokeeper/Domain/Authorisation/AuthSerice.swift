//
//  AuthSerice.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

actor AuthService {
    
    let keychain = KeychainService()
    
    func check() -> Bool {
        keychain[.token] != nil
    }
}
