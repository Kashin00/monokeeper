//
//  EnrichedTransaction.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

struct EnrichedTransaction {
    let transaction: RawTransaction
    let transactionEnrich: TransactionEnrich?
}
