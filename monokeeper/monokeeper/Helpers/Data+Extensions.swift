//
//  Data+Extensions.swift
//  monokeeper
//
//  Created by Matviy Kashin on 18.02.2025.
//

import Foundation

extension Date {
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year, .month], from: .now)) ?? .now
    }
    
    func endOfMonth() -> Date {
        Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth()) ?? .now
    }
}
