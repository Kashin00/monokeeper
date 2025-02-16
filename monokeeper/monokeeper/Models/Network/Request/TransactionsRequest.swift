//
//  TransactionsRequest.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

struct TransactionsRequest: AuthorisableRequest {
    let token: String
    let accountNumber: String
    let from: Int
    let to: Int
}
