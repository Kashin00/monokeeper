//
//  User.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

struct User: Codable {
    struct Account: Codable {
        let id, sendId: String
        let maskedPan: [String]

        enum CodingKeys: String, CodingKey {
            case id, sendId, maskedPan
        }
    }

    
    let clientId, name: String
    let accounts: [Account]

    enum CodingKeys: String, CodingKey {
        case clientId, name, accounts
    }
}
