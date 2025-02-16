//
//  AuthorisableRequest.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

protocol AuthorisableRequest {
    var token: String { get }
}
