//
//  Service.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import Foundation

/// primary API service object to get R&M data
final class AppService {
    /// Shared singleton instance
    static let shared = AppService()

    /// Privatized constructor
    private init () {}
    
    /// Send R&M API call
    ///- Parameters:
    ///     - request: Request instance
    ///     - type: The type of object we expect to get back
    ///     - completion: Callback with data or error
    ///
    ///
    public func execute<T: Codable>(_ request: AppRequest, expecting type: T.Type, complition: @escaping (Result<String, Error>) -> Void) {
        
    }
}
