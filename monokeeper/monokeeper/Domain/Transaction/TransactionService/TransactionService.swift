//
//  TransactionService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

protocol TransactionService {
    func fetch(accounts: [String], from: Int, to: Int) async throws -> [Transaction]
}
