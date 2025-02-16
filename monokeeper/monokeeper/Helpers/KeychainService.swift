//
//  KeychainService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation
import Security

struct KeychainService {
    
    enum Key: String {
        case token
        
        var account: String {
            switch self {
            case .token:
                #if DEBUG
                return "token_dev"
                #else
                return "token"
                #endif
            }
        }
        
        var service: String {
            switch self {
            case .token:
                return "com.monokeeper.token"
            }
        }
    }
    
    subscript(key: Key) -> String? {
        get {
            if let data = read(key: key) {
                return String(data: data, encoding: .utf8)
            } else {
                return nil
            }
        }
        set(newValue) {
            if let newValue, let item = newValue.data(using: .utf8) {
                save(key: key, item: item)
            } else {
                delete(key: key)
            }
        }
    }
    
    private func save(key: Key, item: Data) {
        if  insert(key: key, data: item) == errSecDuplicateItem {
            update(key: key, data: item)
        }
    }
    
    private func read(key: Key) -> Data? {
        let query: [String: Any] = [
            kSecAttrService as String: key.service,
            kSecAttrAccount as String: key.account,
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        
        return (result as? Data)
    }
    
    private func delete(key: Key) {
        let query: [String: Any] = [
            kSecAttrService as String: key.service,
            kSecAttrAccount as String: key.account,
            kSecClass as String: kSecClassGenericPassword,
        ]
        
        SecItemDelete(query as CFDictionary)
    }
    
    private func insert(key: Key, data: Data) -> OSStatus {
        let query: [String: Any] = [
            kSecValueData as String: data,
            kSecAttrAccount as String: key.account,
            kSecAttrService as String: key.service,
            kSecClass as String: kSecClassGenericPassword
        ]

        return SecItemAdd(query as CFDictionary, nil)
    }
    
    private func update(key: Key, data: Data) {
        let query: [String: Any] = [
            kSecAttrAccount as String: key.account,
            kSecAttrService as String: key.service,
            kSecClass as String: kSecClassGenericPassword
        ]

        let attributesToUpdate = [kSecValueData: data]

        SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
    }
}

