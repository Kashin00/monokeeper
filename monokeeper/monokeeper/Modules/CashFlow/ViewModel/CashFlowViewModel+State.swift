//
//  CashFlowViewModel+State.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

extension CashFlowViewModel {
    enum State {
        case loading
        case available([Transaction])
        case notAvailable
        case failed
    }
    
    func updateState(_ state: State) {
        self.state = state
    }
}
 
