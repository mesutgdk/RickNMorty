//
//  Request.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import Foundation

/// Object that represents a single API call
final class AppRequest {
    // Base URL
    // End point
    // Path components
    // Query parameters
    // https://rickandmortyapi.com/api/character
    
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    private let endPoint : AppEndpoint
    
    private let pathComponent: [String]
    
    private let queryParameters: [URLQueryItem]
    
    private var stringUrl: String {
        var string = Constants.baseUrl
        string += "/"
        string += endPoint.rawValue
        
        if !pathComponent.isEmpty {
            pathComponent.forEach(string += "/\($0)")
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            // let name=value & name=value
            let argumentString = queryParameters.compactMap({
                
            })
            queryParameters.forEach(string += "/\($0)")
        }
        
        return string
    }
    
    public var url: URL? {
        return nil
    }
    // MARK: - public

    public init(
        endPoint: AppEndpoint,
        pathComponent: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponent = pathComponent
        self.queryParameters = queryParameters
    }
}
