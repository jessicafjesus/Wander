//
//  ViewState.swift
//  Wander
//
//  Created by Jessica Jesus on 29/03/2026.
//

import MapboxSearch

enum ViewState {
    case idle
    case loading
    case loaded([PlaceAutocomplete.Suggestion])
    case empty
    case error(String)
}
