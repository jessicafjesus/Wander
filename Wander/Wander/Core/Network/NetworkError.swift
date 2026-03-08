//
//  NetworkError.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case unauthorized
    case rateLimited
    case serverError(Int)
    case unexpectedStatusCode(Int)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Something went wrong with the request."
        case .invalidResponse:
            return "Received an unexpected response."
        case .unauthorized:
            return "Authorization failed. Please check your API key."
        case .rateLimited:
            return "Too many requests. Please try again shortly."
        case .serverError(let code):
            return "Server error (\(code)). Please try again later."
        case .unexpectedStatusCode(let code):
            return "Unexpected status code: \(code)."
        case .decodingError(let error):
            return "Failed to process data: \(error.localizedDescription)"
        }
    }
}
