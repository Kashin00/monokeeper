//
//  TransactionEnricher.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

class TransactionEnricher {
    func enrich(_ transactions: [RawTransaction]) -> [EnrichedTransaction] {
        // TODO: ADD ENRICH LOGIC
        return transactions.compactMap({
            EnrichedTransaction(transaction: $0, transactionEnrich: nil)
        })
    }
}
