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
    }
    
    subscript(key: Key) -> Data? {
        get { read(forKey: key.rawValue) }
        set {
            if let data = newValue {
                save(data, forKey: key.rawValue)
            } else {
                delete(forKey: key.rawValue)
            }
        }
    }
    
    private func save(_ data: Data, forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    private func read(forKey key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess else { return nil }
        return dataTypeRef as? Data
    }
    
    func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
