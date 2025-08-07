//
//  TransactionService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

protocol TransactionRepository {
    func fetch(with request: TransactionsFetchRequest) async throws -> [Transaction]
}
