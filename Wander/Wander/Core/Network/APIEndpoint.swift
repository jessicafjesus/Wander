//
//  APIEndpoint.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import Foundation

enum APIEndpoint {
    case searchPlaces(query: String)
    case placeDetails(xid: String)
    
    private var baseURL: String {
        "https://api.opentripmap.com/0.1/en"
    }
    
    private var path: String {
        switch self {
        case .searchPlaces:
            return "/places/geoname"
        case .placeDetails(let xid):
            return "/places/xid/\(xid)"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .searchPlaces(let query):
            return [
                URLQueryItem(name: "name", value: query),
                URLQueryItem(name: "apikey", value: APIKeys.openTripMap)
            ]
        case .placeDetails:
            return [
                URLQueryItem(name: "apikey", value: APIKeys.openTripMap)
            ]
        }
    }
    
    func urlRequest() throws -> URLRequest {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
