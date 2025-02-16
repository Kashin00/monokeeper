//
//  CashFlowViewModel.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation
import SwiftUI

@Observable
class CashFlowViewModel {
    
    enum State {
        case available
        case notAvailable
    }
    
    var state = State.available
    
    func onAppear() {
        
    }
    
}
