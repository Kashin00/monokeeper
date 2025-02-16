//
//  NetworkError.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

enum NetworkError: Error {
    case wrongRequest
    case requestFailed
    case invalidResponse(statusCode: Int)
    case authError
}
