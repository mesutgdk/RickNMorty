//
//  ImageLoader.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 27.07.2023.
//

import Foundation

final class AppImageLoader {
    static let shared = AppImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData> ()

    private init() {}
    
    /// Get image content with URL
    /// -Parameters:
    ///     -url: Source url
    ///     -completion: Callback
    
    func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void)  {
        let key = url.absoluteString as NSString

        if let data = imageDataCache.object(forKey: key) {
//            print("Reading from Cache:\(key)")
            completion(.success(data as Data)) // NSData == Data | NSString == String
            return
        }
            
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key) //  to keep as much cached as possible.
            completion(.success(data))
        }
        task.resume()
    }
    
}
