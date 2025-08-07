//
//  TransactionsFetchRequest.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

struct TransactionsFetchRequest: Equatable {
    let accounts: [String]
    let from: Int
    let to: Int
}

