//
//  ImageLoader.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 27.07.2023.
//

import Foundation

final class AppImageLoader {
    static let shared = AppImageLoader()
    
    
    private init() {}
    
    func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void)  {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
}
