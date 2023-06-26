//
//  AppEndpoint.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import Foundation

/// Represent unique API endpoints
@frozen enum AppEndpoint: String {
    
    /// Endpoint to get char info
    case character // returns "character" if u appoint string to class definition
    
    /// Endpoint to get location info
    case location
    
    /// Endpoint to get char episode
    case episonde
}
