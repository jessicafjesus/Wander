//
//  APIClient.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import Foundation

actor APIClient {
    static let shared = APIClient()
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        self.session = URLSession(configuration: config)
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetch<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        let request = try endpoint.urlRequest()
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return try decoder.decode(T.self, from: data)
        case 401: throw NetworkError.unauthorized
        case 429: throw NetworkError.rateLimited
        case 500...599: throw NetworkError.serverError(httpResponse.statusCode)
        default: throw NetworkError.unexpectedStatusCode(httpResponse.statusCode)
        }
    }
}
