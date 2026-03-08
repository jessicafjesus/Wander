//
//  APIKeys.swift
//  Wander
//
//  Created by Jessica Jesus on 08/03/2026.
//

import Foundation

enum APIKeys {
    static var openTripMap: String {
        guard let key = Bundle.main.object(
            forInfoDictionaryKey: "OpenTripMapAPIKey"
        ) as? String else {
            fatalError("OpenTripMapAPIKey not found in Info.plist")
        }
        return key
    }
}
