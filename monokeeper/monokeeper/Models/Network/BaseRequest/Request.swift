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
    
    case userInfo(UserInfoRequest)
    case transactions(TransactionsRequest)
    
}

extension NetworkRequest {
    var domain: String {
        return "https://api.monobank.ua/"
    }
    
    var path: String {
        switch self {
        case .userInfo:
            return "personal/client-info"
        case let .transactions(request):
            return "personal/statement/\(request.accountNumber)/\(request.from)/\(request.to)"
        }
    }
    
    var method: Method {
        switch self {
        case .userInfo,
                .transactions:
                .get
        }
    }
    
    var body: Data? {
        return nil
    }
    
    var headers: [String: String] {
        switch self {
        case .userInfo(let request):
            return ["X-Token": request.token]
        case .transactions(let request):
            return ["X-Token": request.token]
        }
    }
}
