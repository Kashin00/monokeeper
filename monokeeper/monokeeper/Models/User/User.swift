//
//  User.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

struct User: Codable {
    struct Account: Codable, ManagedObjectConvertible {
        let id, sendId: String
        let maskedPan: [String]

        enum CodingKeys: String, CodingKey {
            case id, sendId, maskedPan
        }
        
        init(dbEntity: AccountEntity) {
            self.id = dbEntity.id
            self.sendId = dbEntity.sendId
            self.maskedPan = dbEntity.maskedPan
        }
        
        func copyPropertiesTo(_ object: AccountEntity) {
            object.id = id
            object.sendId = sendId
            object.maskedPan = maskedPan
        }
    }

    
    let clientId, name: String
    let accounts: [Account]

    enum CodingKeys: String, CodingKey {
        case clientId, name, accounts
    }
}
