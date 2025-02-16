//
//  TransactionResponse.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

struct TransactionResponse: Decodable {
    let id: String
    let time: Int
    let description: String
    let mcc: Int
    let originalMcc: Int
    let amount: Int
    let operationAmount: Int
    let currencyCode: Int
    let commissionRate: Int
    let cashbackAmount: Int
    let balance: Int
    let hold: Bool
}
