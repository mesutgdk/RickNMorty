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
    
    private let cacheManager = AppAPICacheManager()

    /// Privatized constructor
    private init () {}
    
    enum AppServiceError: Error {
        case failureCreatingRequest
        case failedToGetData
    }
    
    /// Send R&M API call
    ///- Parameters:
    ///     - request: Request instance
    ///     - type: The type of object we expect to get back
    ///     - completion: Callback with data or error
    ///
    ///
    public func execute<T: Codable>(
        _ request: AppRequest, expecting type: T.Type, complition: @escaping (Result<T, Error>) -> Void
    ) {
        if let cachedData = cacheManager.cachedResponse(for: request.endPoint,
                                                        url: request.url) {
            print("using cached API Response")
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                complition(.success(result))
            }catch {
                complition(.failure(error))
            }
            return
        }
        
        
        guard let urlRequest = self.request(from: request) else {
            complition(.failure(AppServiceError.failureCreatingRequest))
            return
        }
        
//        print("API Call: \(request.url?.absoluteString ?? "")") 
        let task  = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data,error == nil else {
                complition(.failure(error ?? AppServiceError.failedToGetData))
                return
            }
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endPoint,
                                            url: request.url,
                                            data: data
                )
                complition(.success(result))
               
            }
            catch {
                complition(.failure(error))
            }
            
        }
        task.resume()
        
    }
    
    // MARK: - Private
    
    private func request(from appRequest: AppRequest) -> URLRequest? {
        guard let url = appRequest.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = appRequest.httpMethod
        
        return request
    }

}
