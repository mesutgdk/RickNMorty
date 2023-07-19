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
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endPoint : AppEndpoint
    
    /// Path Components for API, if any
    private let pathComponent: [String]
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// constructed url for the API request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endPoint.rawValue
        
        if !pathComponent.isEmpty {
            pathComponent.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            // let name=value & name=value
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    // MARK: - public

    /// Conquest request
    ///- Parameters:
    ///     - endpoint: Target endpoint
    ///     - pathComponent: Collection of Path components
    ///     - quetryParameters: Collection of quert parameters
    public init(
        endPoint: AppEndpoint,
        pathComponent: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponent = pathComponent
        self.queryParameters = queryParameters
    }
    
    convenience init?(url:URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl){
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                if let appEndpoint = AppEndpoint(rawValue: endpointString) {
                    self.init(endPoint:appEndpoint)
                    return
                }
                
            }
        } else if trimmed.contains("?"){
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty {
                let endpointString = components[0]
                if let appEndpoint = AppEndpoint(rawValue: endpointString) {
                    self.init(endPoint:appEndpoint)
                    return
                }
                
            }
        }
        return nil
    }
}

extension AppRequest {
    static let listCharacterRequests = AppRequest(endPoint: .character)
}
