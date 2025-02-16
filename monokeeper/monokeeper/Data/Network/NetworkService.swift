//
//  NetworkService.swift
//  monokeeper
//
//  Created by Matviy Kashin on 16.02.2025.
//

import Foundation

actor NetworkService: Networkable {

    private let session = URLSession.shared
    
    private func buildRequest(for request: NetworkRequest) throws(NetworkError) -> URLRequest {
        guard let url = URL(string: request.domain + request.path) else {
            throw NetworkError.wrongRequest
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        request.headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }

        
        return urlRequest
    }
    
    func request<T: Decodable & Sendable>(_ request: NetworkRequest) async throws(NetworkError) -> T {
        let request = try buildRequest(for: request)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse(statusCode: -1)
            }
            
            switch httpResponse.statusCode {
                case 200..<300:
                return try JSONDecoder().decode(T.self, from: data)
            default:
                throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
            }
            
        } catch {
            throw NetworkError.requestFailed
        }
    }
}
