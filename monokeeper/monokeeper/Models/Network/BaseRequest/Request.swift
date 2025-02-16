//
//  Request.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

enum NetworkRequest {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    case userInfo
    
}

extension NetworkRequest {
    var domain: String {
        return "https://api.monobank.ua/"
    }
    
    var path: String {
        switch self {
        case .userInfo:
            "personal/client-info"
        }
    }
    
    var method: Method {
        switch self {
        case .userInfo:
                .get
        }
    }
    
    var body: Data? {
        return nil
    }
    
    var headers: [String: String] {
        switch self {
        case .userInfo:
            ["X-Token": "uW3Ncl6btBTNmKh6coVIgiaNcF5zy5rswSJt_iNjE4FQ"]
        }
    }
}
