//
//  Networkable.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

protocol Networkable {
    func request<T: Decodable & Sendable>(_ request: NetworkRequest) async throws(NetworkError) -> T
}
