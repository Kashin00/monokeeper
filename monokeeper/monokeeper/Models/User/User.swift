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
        let currencyCode: Int
        let cashbackType: String
        let balance, creditLimit: Int
        let maskedPan: [String]
        let type, iban: String

        enum CodingKeys: String, CodingKey {
            case id
            case sendId
            case currencyCode, cashbackType, balance, creditLimit, maskedPan, type, iban
        }
    }

    
    let clientID, name, webHookURL, permissions: String
    let accounts: [Account]

    enum CodingKeys: String, CodingKey {
        case clientID = "clientId"
        case name
        case webHookURL = "webHookUrl"
        case permissions, accounts
    }
}
